import 'package:brainwavesocialapp/constants/collections.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exceptions/app_exceptions.dart';
import '../interfaces/user_interface.dart';
import '../models/post.dart';
import '../models/userinfo.dart';

class _UserRemoteDataSource implements UserRepository {
  const _UserRemoteDataSource(
    this.databaseDataSource,
  );

  final FirebaseFirestore databaseDataSource;

  @override
  Future<void> createUser(UserInfoDataModel user) {
    try {
      return databaseDataSource
          .collection(CollectionsName.users.name)
          .doc(user.uid)
          .set(
            user.toJson(),
            SetOptions(merge: true),
          );
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Stream<UserInfoDataModel> getExtraUserInfo(String uid) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .snapshots()
        .map(
          (event) => UserInfoDataModel.fromJson(
            {
              ...event.data()!,
              'uid': event.id,
            },
          ),
        );
  }

  @override
  Future<List<PostDataModel>> getUserPosts(String uid) {
    return databaseDataSource
        .collection(CollectionsName.posts.name)
        .where('ownerId', isEqualTo: uid)
        // need to explain compound queries in firestore
        .orderBy('timestamp', descending: true)
        // explain pagination
        .limit(10)
        // explain startAt and EndAt in firestore
        .withConverter(
          fromFirestore: (snapshot, _) {
            return PostDataModel.fromJson({
              ...snapshot.data()!,
              'uid': snapshot.id,
            });
          },
          toFirestore: (data, _) => data.toJson(),
        )
        .get()
        .then((value) => value.docs
            .map(
              (e) => e.data(),
            )
            .toList());
  }

  @override
  Future<List<UserInfoDataModel>> searchUsers() {
    return databaseDataSource
        .collection(
          CollectionsName.users.name,
        )
        .get()
        .then(
      (value) {
        return value.docs
            .map(
              (e) => UserInfoDataModel.fromJson(
                {
                  ...e.data(),
                  'uid': e.id,
                },
              ),
            )
            .toList();
      },
    );
  }

  @override
  Stream<List<String>?> getFollowings(
    String uid,
  ) {
    return databaseDataSource
        .collection(CollectionsName.following.name)
        .doc(uid)
        .collection(CollectionsName.users.name)
        .snapshots()
        .map(
          (event) => event.docs.map((e) => e.id).toList(),
        )
        .asBroadcastStream();
  }

  @override
  Future<void> followUser(
    String currentUserId,
    String idUserToFollow,
  ) async {
    await databaseDataSource
        .collection(CollectionsName.following.name)
        .doc(currentUserId)
        .collection(CollectionsName.users.name)
        .doc(idUserToFollow)
        .set(
      {
        'timestamp': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    await databaseDataSource
        .collection(CollectionsName.followers.name)
        .doc(idUserToFollow)
        .collection(CollectionsName.users.name)
        .doc(currentUserId)
        .set(
      {
        'timestamp': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> unFollowUser(
    String currentUserId,
    String idUserToUnfollow,
  ) async {
    await databaseDataSource
        .collection(CollectionsName.following.name)
        .doc(currentUserId)
        .collection(CollectionsName.users.name)
        .doc(idUserToUnfollow)
        .delete();

    await databaseDataSource
        .collection(CollectionsName.followers.name)
        .doc(idUserToUnfollow)
        .collection(CollectionsName.users.name)
        .doc(currentUserId)
        .delete();
  }

  @override
  Future<void> editUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  }) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update(
      {
        'firstName': firstName,
        'lastName': lastName,
        'bio': bio,
      },
    );
  }

  @override
  Stream<bool> userLikedAPost(String postId, String userId) {
    return databaseDataSource
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.likes.name)
        .doc(userId)
        .snapshots()
        .map((value) => value.exists);
  }

  @override
  Future<int?> getFollowersCount(String uid) {
    return databaseDataSource
        .collection(CollectionsName.followers.name)
        .doc(uid)
        .collection(CollectionsName.users.name)
        .count()
        .get()
        .then((value) => value.count);
  }

  @override
  Future<int?> getFollowingCount(String uid) {
    return databaseDataSource
        .collection(CollectionsName.following.name)
        .doc(uid)
        .collection(CollectionsName.users.name)
        .count()
        .get()
        .then((value) => value.count);
  }

  @override
  Future<void> updateAvatarImage({required String uid, String? photoUrl}) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update(
      {
        'photoUrl': photoUrl,
      },
    );
  }

  @override
  Future<void> updateCoverImage({required String uid, String? coverImageUrl}) {
    return databaseDataSource
        .collection(CollectionsName.users.name)
        .doc(uid)
        .update(
      {
        'coverImageUrl': coverImageUrl,
      },
    );
  }

  @override
  Future<void> updateUserDeviceToken(String uid, String token) {
    final ref = databaseDataSource
        .collection(
          CollectionsName.users.name,
        )
        .doc(
          uid,
        );

    return ref.set(
      {
        'deviceTokens': FieldValue.arrayUnion([token]),
      },
      SetOptions(merge: true),
    );
  }
}

final userDataSourceProvider = Provider(
  (ref) => _UserRemoteDataSource(FirebaseFirestore.instance),
);
