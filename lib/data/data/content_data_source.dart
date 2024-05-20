import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/collections.dart';
import '../interfaces/content_interface.dart';
import '../models/comment.dart';
import '../models/post.dart';

class _ContentDataSource implements ContentRepository {
  _ContentDataSource({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  Stream<List<PostDataModel>> getFeeds(
    List<String> followingUsers,
  ) {
    return firestore
        .collection(CollectionsName.posts.name)
        .where(
          'ownerId',
          whereIn: followingUsers,
        )
        .orderBy('timestamp', descending: true)
        .limit(100)
        .withConverter<PostDataModel>(
          fromFirestore: (snapshot, _) => PostDataModel.fromJson(
            {
              ...snapshot.data()!,
              'uid': snapshot.id,
            },
          ),
          toFirestore: (post, _) => post.toJson(),
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }

  @override
  Future<PostDataModel?> createPost({
    required String content,
    required String userId,
  }) async {
    try {
      final post = PostDataModel(
        uid: '',
        content: content,
        ownerId: userId,
        timestamp: DateTime.now(),
      );

      final document = await firestore
          .collection(
            CollectionsName.posts.name,
          )
          .withConverter<PostDataModel>(
            fromFirestore: (snapshot, _) => PostDataModel.fromJson(
              {
                ...snapshot.data()!,
                'uid': snapshot.id,
              },
            ),
            toFirestore: (post, _) => post.toJson(),
          )
          .add(post);

      return document.get().then((snapshot) => snapshot.data()!);
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  @override
  Future<void> deletePost(String postId) {
    return firestore
        .collection(
          CollectionsName.posts.name,
        )
        .doc(
          postId,
        )
        .delete();
  }

  @override
  Future<void> updatePost(PostDataModel post) {
    return firestore
        .collection(
          CollectionsName.posts.name,
        )
        .withConverter<PostDataModel>(
          fromFirestore: (snapshot, _) => PostDataModel.fromJson(
            {
              ...snapshot.data()!,
              'uid': snapshot.id,
            },
          ),
          toFirestore: (post, _) => post.toJson(),
        )
        .doc(
          post.uid,
        )
        .set(
          post,
          SetOptions(merge: true),
        );
  }

  @override
  Stream<PostDataModel> getPost(String postId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .withConverter<PostDataModel>(
          fromFirestore: PostDataModel.fromFirestore,
          toFirestore: (post, _) => post.toJson(),
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.data()!,
        );
  }

  @override
  Future<void> commentPost(
    String postId,
    String userId,
    String comment,
  ) {
    return firestore
        .collection(
          CollectionsName.posts.name,
        )
        .doc(
          postId,
        )
        .collection(
          CollectionsName.comments.name,
        )
        .add(
      {
        'content': comment,
        'postId': postId,
        'ownerId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      },
    );
  }

  @override
  Stream<List<CommentDataModel>> getPostComments(
    String postId,
  ) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.comments.name)
        .orderBy('createdAt', descending: false)
        .limit(40)
        .withConverter<CommentDataModel>(
          fromFirestore: CommentDataModel.fromFirestore,
          toFirestore: (comment, _) => comment.toJson(),
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => doc.data(),
              )
              .toList(),
        );
  }

  @override
  Future<List<PostDataModel>> getUserPosts(String uid) async {
    return firestore
        .collection(CollectionsName.posts.name)
        .where('ownerId', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .limit(50)
        .withConverter<PostDataModel>(
          fromFirestore: PostDataModel.fromFirestore,
          toFirestore: (post, _) => post.toJson(),
        )
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }

  @override
  Future<void> likePost(String postId, String userId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.likes.name)
        .doc(userId)
        .set({
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> unLikePost(String postId, String userId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.likes.name)
        .doc(userId)
        .delete();
  }

  @override
  Future<int?> getPostLikesCount(String postId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.likes.name)
        .count()
        .get()
        .then(
          (event) => event.count,
        );
  }

  @override
  Future<int?> getPostCommentCount(String postId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.comments.name)
        .count()
        .get()
        .then(
          (event) => event.count,
        );
  }

  @override
  Future<void> deleteComment(String commendId, String postId) {
    return firestore
        .collection(CollectionsName.posts.name)
        .doc(postId)
        .collection(CollectionsName.comments.name)
        .doc(commendId)
        .delete();
  }
}

final contentDataSourceProvider = Provider(
  (ref) => _ContentDataSource(
    firestore: FirebaseFirestore.instance
      ..settings = const Settings(
        persistenceEnabled: true,
      ),
  ),
);
