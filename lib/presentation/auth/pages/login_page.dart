import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/exceptions/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/login_state.dart';
import '../widgets/social_login.dart';
import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateProvider);

    // in case of error show a snackbar
    ref.listen(
      loginStateProvider,
      (prev, next) {
        if (next.hasError) {
          final error = next.error;
          debugPrint('Error: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error is AppFirebaseException
                    ? error.message
                    : 'Something went wrong!',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
    );

    return CommonPageScaffold(
      title: 'Login',
      child: loginState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const WelcomeText(),
                GapWidgets.h16,
                UserPassForm(
                  buttonLabel: 'Login',
                  onFormSubmit: (
                    String email,
                    String password,
                  ) async {
                    ref
                        .read(
                          loginStateProvider.notifier,
                        )
                        .loginWithEmailPassword(
                          email,
                          password,
                        );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        AppRouter.go(
                          context,
                          RouterNames.registerPage,
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        AppRouter.go(
                          context,
                          RouterNames.forgotPasswordPage,
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                GapWidgets.h8,
                const Text('Or login with'),
                SocialLogin(
                  onGooglePressed: () {
                    ref
                        .read(
                          loginStateProvider.notifier,
                        )
                        .signInGoogle();
                  },
                  onApplePressed: () {
                    ref
                        .read(
                          loginStateProvider.notifier,
                        )
                        .signInApple();
                  },
                ),
              ],
            ),
    );
  }
}
