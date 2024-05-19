import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget with EmailPassValidators {
  ForgotPasswordPage({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonPageScaffold(
      title: 'Forgot Password',
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Reset your password.'),
            GapWidgets.h8,
            AppTextFormField(
              fieldController: emailController,
              fieldValidator: validateEmail,
              label: 'Email',
            ),
            GapWidgets.h8,
            HighlightButton(
              text: 'Send me an email',
              onPressed: () {
                // Todo: handle forgot password logic
              },
            ),
            GapWidgets.h48,
          ],
        ),
      ),
    );
  }
}
