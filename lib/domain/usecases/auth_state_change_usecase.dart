import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1- First abstract the class
abstract interface class AuthStateUserCase {
  Stream<bool> isAuthenticated();
}

// 2- Implement the class
class _RegisterUserCase implements AuthStateUserCase {
  _RegisterUserCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  isAuthenticated() {
    return _authRepository.isUserAuthenticated();
  }
}

// 3- Create a provider
final authStateUseCaseProvider = Provider<AuthStateUserCase>(
  (ref) => _RegisterUserCase(ref.watch(authRepositoryProvider)),
);
