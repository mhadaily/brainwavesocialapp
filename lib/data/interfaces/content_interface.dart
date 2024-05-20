import '../models/comment.dart';
import '../models/post.dart';

abstract interface class ContentRepository {
  Stream<List<PostDataModel>> getFeeds(List<String> followingUsersIds);
  Future<List<PostDataModel>> getUserPosts(String uid);
  Stream<PostDataModel> getPost(String postId);
  Future<PostDataModel?> createPost({
    required String content,
    required String userId,
  });
  Future<void> deletePost(String postId);
  Future<void> updatePost(PostDataModel post);
  Future<void> likePost(String postId, String userId);
  Future<void> unLikePost(String postId, String userId);
  Future<void> commentPost(
    String postId,
    String userId,
    String comment,
  );
  Stream<List<CommentDataModel>> getPostComments(String postId);
  Future<int?> getPostLikesCount(String postId);
  Future<int?> getPostCommentCount(String postId);
  Future<void> deleteComment(String postId, String commentId);
}
