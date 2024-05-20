import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
  });

  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: onGooglePressed,
          child: const Text('Google'),
        ),
        GapWidgets.w16,
        OutlinedButton(
          onPressed: onApplePressed,
          child: const Text('Apple'),
        ),
      ],
    );
  }
}
