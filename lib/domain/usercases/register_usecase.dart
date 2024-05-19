import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class RegisterUseCase {
  Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
  });
}

class _RegisterUserCase implements RegisterUseCase {
  _RegisterUserCase(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return authRepository
        .registerWithEmailPassword(
          email: email,
          password: password,
        )
        .then((value) => value != null);
  }
}

final registerUseCaseProvider = Provider<_RegisterUserCase>(
  (ref) => _RegisterUserCase(
    ref.watch(authRepositoryProvider),
  ),
);
