import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';
import '../entity/comment.dart';
import '../entity/post.dart';

abstract interface class PostDetailUseCase {
  Stream<Post> getPostDetail(String postId);
  Stream<List<Comment>> getPostComments(String postId);
  Future<void> deletePost(String postId);
  Future<void> commentPost(
    String postId,
    String ownerId,
    String comment,
  );
  Future<void> deleteComment(String commentId, String postId);
}

class _PostDetailUseCase implements PostDetailUseCase {
  _PostDetailUseCase(
    this._postRepository,
  );

  final ContentRepository _postRepository;

  @override
  Future<void> deletePost(String postId) {
    return _postRepository.deletePost(postId);
  }

  @override
  Stream<Post> getPostDetail(String postId) {
    return _postRepository.getPost(postId).map(
          (post) => Post.fromDataModel(post),
        );
  }

  @override
  Stream<List<Comment>> getPostComments(String postId) {
    return _postRepository.getPostComments(postId).map(
          (comments) => comments
              .map((comment) => Comment.fromDataModel(comment))
              .toList(),
        );
  }

  @override
  Future<void> commentPost(
    String postId,
    String ownerId,
    String comment,
  ) {
    return _postRepository.commentPost(
      postId,
      ownerId,
      comment,
    );
  }

  @override
  Future<void> deleteComment(String commentId, String postId) {
    return _postRepository.deleteComment(commentId, postId);
  }
}

// 3- Create a provider
final postDetailUseCaseProvider = Provider<PostDetailUseCase>(
  (ref) => _PostDetailUseCase(
    ref.watch(postRepositoryProvider),
  ),
);
