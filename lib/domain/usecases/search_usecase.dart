import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/user.dart';

abstract interface class SearchUseCase {
  Future<List<AppUser>> searchUsers();
}

class _SearchUseCase implements SearchUseCase {
  const _SearchUseCase(
    this._authRepository,
    this._userRepository,
  );

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  @override
  Future<List<AppUser>> searchUsers() async {
    final currentUser = _authRepository.currentUser;
    final usersDataModel = await _userRepository.searchUsers();
    return usersDataModel
        .map(
          (user) => AppUser.fromUserInfoDataModel(user),
        )
        .where(
          (user) => user.uid != currentUser.uid,
        )
        .toList();
  }
}

// 3- Create a provider
final searchUseCaseProvider = Provider<SearchUseCase>(
  (ref) => _SearchUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
