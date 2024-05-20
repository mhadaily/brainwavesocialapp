import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1- First abstract the class
abstract interface class LoginUserCase {
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<bool> loginWithGoogle();
  Future<bool> loginWithApple();
}

// 2- Implement the class
class _LoginUserCase implements LoginUserCase {
  _LoginUserCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );
    final isUserLoggedIn = user.email != null;

    return isUserLoggedIn;
  }

  @override
  loginWithGoogle() async {
    final user = await _authRepository.loginWithGoogle();
    final isUserLoggedIn = user.email != null;

    return isUserLoggedIn;
  }

  @override
  loginWithApple() async {
    final user = await _authRepository.loginWithApple();
    final isUserLoggedIn = user.email != null;

    return isUserLoggedIn;
  }
}

// 3- Create a provider
final loginUseCaseProvider = Provider<LoginUserCase>(
  (ref) => _LoginUserCase(
    ref.watch(authRepositoryProvider),
  ),
);
