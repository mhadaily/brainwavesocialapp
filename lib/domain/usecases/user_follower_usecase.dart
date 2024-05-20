import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data.dart';

abstract interface class UserFollowerUseCase {
  Stream<List<String>> getCurrentUserFollowings();
  Future<void> followUser(String uid);
  Future<void> unFollowUser(String uid);
  Future<int> getFollowersCount(String uid);
  Future<int> getFollowingCount(String uid);
}

class _UserFollowerUseCase implements UserFollowerUseCase {
  const _UserFollowerUseCase(
    this._userRepository,
    this._authRepository,
  );

  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  @override
  Stream<List<String>> getCurrentUserFollowings() {
    final user = _authRepository.currentUser;
    return _userRepository
        .getFollowings(
      user.uid,
    )
        .handleError(
      (error, stackTrace) {
        return [];
      },
    ).map((event) {
      if (event != null) {
        return event;
      }
      return [];
    });
  }

  @override
  Future<void> followUser(String idUserToFollow) {
    final currentUser = _authRepository.currentUser;
    return _userRepository.followUser(
      currentUser.uid,
      idUserToFollow,
    );
  }

  @override
  Future<void> unFollowUser(String idUserToUnfollow) {
    final currentUser = _authRepository.currentUser;
    return _userRepository.unFollowUser(currentUser.uid, idUserToUnfollow);
  }

  @override
  Future<int> getFollowersCount(String uid) async {
    return await _userRepository.getFollowersCount(uid) ?? 0;
  }

  @override
  Future<int> getFollowingCount(String uid) async {
    return await _userRepository.getFollowingCount(uid) ?? 0;
  }
}

final userFollowerUseCaseProvider = Provider<UserFollowerUseCase>(
  (ref) => _UserFollowerUseCase(
    ref.watch(userRepositoryProvider),
    ref.watch(authRepositoryProvider),
  ),
);
