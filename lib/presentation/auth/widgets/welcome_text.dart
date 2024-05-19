import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome to BrainWave!',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
