import 'package:brainwavesocialapp/domain/usercases/login_usercase.dart';
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
}
