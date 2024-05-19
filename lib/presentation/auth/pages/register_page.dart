import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';

import '../widgets/user_pass_form.dart';
import '../widgets/welcome_text.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              // todo: handle register logic
            },
          ),
          GapWidgets.h48,
        ],
      ),
    );
  }
}
