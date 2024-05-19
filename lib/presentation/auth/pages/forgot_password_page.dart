import 'package:brainwavesocialapp/common/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonPageScaffold(
      title: 'ForgotPassword',
      child: Center(
        child: Text('ForgotPassword Page'),
      ),
    );
  }
}
