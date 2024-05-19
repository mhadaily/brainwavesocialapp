import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            // Todo: Handle Google login logic
          },
          child: const Text('Google'),
        ),
        GapWidgets.w16,
        OutlinedButton(
          onPressed: () {
            // Todo: Handle Apple login logic
          },
          child: const Text('Apple'),
        ),
      ],
    );
  }
}
