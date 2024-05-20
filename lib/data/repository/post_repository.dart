import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/content_data_source.dart';
import '../interfaces/content_interface.dart';
import '../models/comment.dart';
import '../models/post.dart';

class _PostRepository implements ContentRepository {
  const _PostRepository(
    this.contentDataSource,
  );
  final ContentRepository contentDataSource;

  @override
  Future<void> commentPost(
    String postId,
    String userId,
    String comment,
  ) {
    return contentDataSource.commentPost(
      postId,
      userId,
      comment,
    );
  }

  @override
  Future<PostDataModel?> createPost({
    required String content,
    required String userId,
  }) {
    return contentDataSource.createPost(
      content: content,
      userId: userId,
    );
  }

  @override
  Future<void> deletePost(String postId) {
    return contentDataSource.deletePost(postId);
  }

  @override
  Stream<List<PostDataModel>> getFeeds(
    List<String> followingUsersIds,
  ) {
    return contentDataSource.getFeeds(followingUsersIds);
  }

  @override
  Stream<PostDataModel> getPost(String postId) {
    return contentDataSource.getPost(postId);
  }

  @override
  Stream<List<CommentDataModel>> getPostComments(String postId) {
    return contentDataSource.getPostComments(postId);
  }

  @override
  Future<List<PostDataModel>> getUserPosts(String uid) {
    return contentDataSource.getUserPosts(uid);
  }

  @override
  Future<void> updatePost(PostDataModel post) {
    return contentDataSource.updatePost(post);
  }

  @override
  Future<void> likePost(String postId, String userId) {
    return contentDataSource.likePost(postId, userId);
  }

  @override
  Future<void> unLikePost(String postId, String userId) {
    return contentDataSource.unLikePost(postId, userId);
  }

  @override
  Future<int?> getPostLikesCount(String postId) {
    return contentDataSource.getPostLikesCount(postId);
  }

  @override
  Future<int?> getPostCommentCount(String postId) {
    return contentDataSource.getPostCommentCount(postId);
  }

  @override
  Future<void> deleteComment(String commentId, String postId) {
    return contentDataSource.deleteComment(commentId, postId);
  }
}

final postRepositoryProvider = Provider<ContentRepository>(
  (ref) => _PostRepository(
    ref.watch(contentDataSourceProvider),
  ),
);
