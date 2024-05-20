import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/post.dart';
import '../entity/user.dart';

abstract interface class UserUseCase {
  Stream<AppUser> getUserInfo(String uid);
  Future<List<Post>> getUserPosts(String uid);
  Stream<AppUser> getCurrentUserInfo();
  Future<void> signOut();
  Stream<bool> isUserLikedPost(String postId);
}

class _UserUseCase implements UserUseCase {
  const _UserUseCase(
    this._authRepository,
    this._userRepository,
  );

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  @override
  Stream<AppUser> getUserInfo(String uid) {
    return _userRepository
        .getExtraUserInfo(
          uid,
        )
        .map(
          (userDataModel) => AppUser.fromUserInfoDataModel(userDataModel),
        );
  }

  @override
  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  Future<List<Post>> getUserPosts(String uid) {
    return _userRepository
        .getUserPosts(
          uid,
        )
        .then(
          (posts) => posts
              .map(
                (post) => Post.fromDataModel(post),
              )
              .toList(),
        );
  }

  @override
  Stream<AppUser> getCurrentUserInfo() {
    final user = _authRepository.currentUser;
    return getUserInfo(user.uid);
  }

  @override
  Stream<bool> isUserLikedPost(String postId) {
    final currentUser = _authRepository.currentUser;
    return _userRepository.userLikedAPost(
      postId,
      currentUser.uid,
    );
  }
}

// 3- Create a provider
final userUseCaseProvider = Provider<UserUseCase>(
  (ref) => _UserUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
