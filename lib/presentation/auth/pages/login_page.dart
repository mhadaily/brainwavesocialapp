import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';

import '../widgets/social_login.dart';
import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageScaffold(
      title: 'Login',
      child: Column(
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
              // todo: handle login logic
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
          const SocialLogin(),
        ],
      ),
    );
  }
}
