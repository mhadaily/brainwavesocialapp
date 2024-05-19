import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    this.onGoogleLogin,
    this.onAppleLogin,
  });

  final VoidCallback? onGoogleLogin;
  final VoidCallback? onAppleLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: onGoogleLogin,
          child: const Text('Google'),
        ),
        GapWidgets.w16,
        OutlinedButton(
          onPressed: onAppleLogin,
          child: const Text('Apple'),
        ),
      ],
    );
  }
}
