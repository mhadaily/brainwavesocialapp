import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1- First abstract the class
abstract interface class ForgotPasswordUserCase {
  Future<void> forgotPassword(String email);
}

// 2- Implement the class
class _ForgotPasswordUserCase implements ForgotPasswordUserCase {
  _ForgotPasswordUserCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  forgotPassword(String email) {
    return _authRepository.forgotPassword(email);
  }
}

// 3- Create a provider
final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUserCase>(
  (ref) => _ForgotPasswordUserCase(ref.watch(authRepositoryProvider)),
);
