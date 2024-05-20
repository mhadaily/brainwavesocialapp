import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class PostLikeUseCase {
  Stream<bool> hasCurrentUserLikedPost(String postId);
  Future<void> toggleCurrentUserPostLike(String postId);
  Future<int> getPostLikesCount(String postId);
  Future<int> getPostCommentCount(String postId);
}

class _PostLikeUseCase implements PostLikeUseCase {
  const _PostLikeUseCase(
    this._userRepository,
    this._postRepository,
    this._authRepository,
  );

  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final ContentRepository _postRepository;

  @override
  Stream<bool> hasCurrentUserLikedPost(String postId) {
    final currentUser = _authRepository.currentUser;
    return _userRepository.userLikedAPost(postId, currentUser.uid);
  }

  @override
  Future<void> toggleCurrentUserPostLike(String postId) async {
    final user = _authRepository.currentUser;
    final isPostLiked =
        await _userRepository.userLikedAPost(postId, user.uid).first;
    if (!isPostLiked) {
      return _postRepository.likePost(
        postId,
        user.uid,
      );
    }

    return _postRepository.unLikePost(
      postId,
      user.uid,
    );
  }

  @override
  Future<int> getPostLikesCount(String postId) {
    return _postRepository.getPostLikesCount(postId).then(
          (count) => count ?? 0,
        );
  }

  @override
  Future<int> getPostCommentCount(String postId) {
    return _postRepository.getPostCommentCount(postId).then(
          (count) => count ?? 0,
        );
  }
}

final postLikeUseCaseProvider = Provider<PostLikeUseCase>(
  (ref) => _PostLikeUseCase(
    ref.watch(userRepositoryProvider),
    ref.watch(postRepositoryProvider),
    ref.watch(authRepositoryProvider),
  ),
);
