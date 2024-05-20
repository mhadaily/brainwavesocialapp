import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1- First abstract the class
abstract interface class RegisterUserCase {
  Future<bool> registerWithEmailPassword({
    required String email,
    required String password,
  });
}

// 2- Implement the class
class _RegisterUserCase implements RegisterUserCase {
  _RegisterUserCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  registerWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _authRepository
        .registerWithEmailPassword(
          email: email,
          password: password,
        )
        .then((value) => value.email != null);
  }
}

// 3- Create a provider
final registerUseCaseProvider = Provider<RegisterUserCase>(
  (ref) => _RegisterUserCase(ref.watch(authRepositoryProvider)),
);
