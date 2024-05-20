import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:brainwavesocialapp/exceptions/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/forgot_password_state.dart';

class ForgotPasswordPage extends ConsumerWidget with EmailPassValidators {
  ForgotPasswordPage({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPassState = ref.watch(forgotPassStateProvider);
    ref.listen(
      forgotPassStateProvider,
      (prev, next) {
        if (next.hasError) {
          final error = next.error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error is AppException ? error.message : 'An error occurred',
              ),
            ),
          );
          return;
        }
      },
    );
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
            forgotPassState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : HighlightButton(
                    text: 'Send me an email',
                    onPressed: () {
                      ref
                          .read(
                            forgotPassStateProvider.notifier,
                          )
                          .forgotPassword(
                            emailController.text,
                          );
                    },
                  ),
            GapWidgets.h48,
          ],
        ),
      ),
    );
  }
}
