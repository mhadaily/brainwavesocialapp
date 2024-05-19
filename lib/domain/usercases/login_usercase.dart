import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class LoginUserCase {
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<bool> loginWithGoogle();
  Future<bool> loginWithApple();
}

class _LoginUserCase implements LoginUserCase {
  _LoginUserCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Future<bool> loginWithGoogle() async {
    final user = await _authRepository.loginWithGoogle();
    return user.email != null;
  }

  @override
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _authRepository
        .loginWithEmailPassword(
          email: email,
          password: password,
        )
        .then((value) => value != null);
  }

  @override
  Future<bool> loginWithApple() async {
    final user = await _authRepository.loginWithApple();
    return user.email != null;
  }
}

final loginUseCaseProvider = Provider<_LoginUserCase>(
  (ref) => _LoginUserCase(
    ref.watch(authRepositoryProvider),
  ),
);
