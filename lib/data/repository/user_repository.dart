import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/user_data_source.dart';
import '../interfaces/user_interface.dart';
import '../models/post.dart';
import '../models/userinfo.dart';

class _UserRepository implements UserRepository {
  const _UserRepository({
    required this.databaseDataSource,
  });

  final UserRepository databaseDataSource;

  @override
  Stream<UserInfoDataModel> getExtraUserInfo(String uid) {
    return databaseDataSource.getExtraUserInfo(uid);
  }

  @override
  Future<List<PostDataModel>> getUserPosts(String uid) {
    return databaseDataSource.getUserPosts(uid);
  }

  @override
  Future<void> createUser(UserInfoDataModel user) {
    return databaseDataSource.createUser(user);
  }

  @override
  Future<List<UserInfoDataModel>> searchUsers() {
    return databaseDataSource.searchUsers();
  }

  @override
  Stream<List<String>?> getFollowings(String uid) {
    return databaseDataSource.getFollowings(uid);
  }

  @override
  Future<void> followUser(String currentUserId, String idUserToFollow) {
    return databaseDataSource.followUser(currentUserId, idUserToFollow);
  }

  @override
  Future<void> unFollowUser(String currentUserId, String idUserToUnfollow) {
    return databaseDataSource.unFollowUser(currentUserId, idUserToUnfollow);
  }

  @override
  Future<void> editUserProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  }) {
    return databaseDataSource.editUserProfile(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      bio: bio,
    );
  }

  @override
  Stream<bool> userLikedAPost(String postId, String userId) {
    return databaseDataSource.userLikedAPost(postId, userId);
  }

  @override
  Future<int?> getFollowersCount(String uid) {
    return databaseDataSource.getFollowersCount(uid);
  }

  @override
  Future<int?> getFollowingCount(String uid) {
    return databaseDataSource.getFollowingCount(uid);
  }

  @override
  Future<void> updateUserDeviceToken(String uid, String token) {
    return databaseDataSource.updateUserDeviceToken(uid, token);
  }

  @override
  Future<void> updateAvatarImage({required String uid, String? photoUrl}) {
    return databaseDataSource.updateAvatarImage(uid: uid, photoUrl: photoUrl);
  }

  @override
  Future<void> updateCoverImage({required String uid, String? coverImageUrl}) {
    return databaseDataSource.updateCoverImage(
      uid: uid,
      coverImageUrl: coverImageUrl,
    );
  }
}

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => _UserRepository(
    databaseDataSource: ref.watch(userDataSourceProvider),
  ),
);
