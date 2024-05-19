import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/presentation/auth/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonPageScaffold(
      title: 'Sign Up',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const WelcomeText(),
          GapWidgets.h48,
          UserPassForm(
            buttonLabel: 'Sign Up',
            onFormSubmit: (String email, String password) {
              ref
                  .read(registerStateProvider.notifier)
                  .registerWithEmailPassword(
                    email,
                    password,
                  );
            },
          ),
          GapWidgets.h48,
        ],
      ),
    );
  }
}
