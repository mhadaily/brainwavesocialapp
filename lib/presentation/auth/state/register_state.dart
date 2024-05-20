import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerStateProvider = AsyncNotifierProvider<RegisterState, bool>(
  () {
    return RegisterState();
  },
);

class RegisterState extends AsyncNotifier<bool> {
  get _registerUseCase => ref.read(registerUseCaseProvider);

  @override
  bool build() => false;

  registerWithEmailPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return _registerUseCase.registerWithEmailPassword(
        email: email,
        password: password,
      );
    });
  }
}
