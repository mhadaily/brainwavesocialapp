import 'package:brainwavesocialapp/common/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonPageScaffold(
      title: 'Register',
      child: Center(
        child: Text(
          'Register Page',
        ),
      ),
    );
  }
}
