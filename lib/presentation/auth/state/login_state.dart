import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginStateProvider = AsyncNotifierProvider<LoginState, bool>(
  () {
    return LoginState();
  },
);

class LoginState extends AsyncNotifier<bool> {
  @override
  bool build() => false;

  loginWithEmailPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref
          .watch(
            loginUseCaseProvider,
          )
          .loginWithEmailPassword(
            email: email,
            password: password,
          );
    });
  }

  signInGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref
          .watch(
            loginUseCaseProvider,
          )
          .loginWithGoogle();
    });
  }

  signInApple() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref
          .watch(
            loginUseCaseProvider,
          )
          .loginWithApple();
    });
  }
}
