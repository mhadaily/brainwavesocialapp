import 'package:brainwavesocialapp/common/routing/route_names.dart';
import 'package:brainwavesocialapp/common/routing/router.dart';
import 'package:brainwavesocialapp/common/widgets/page_scaffold.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPageScaffold(
      title: 'Login',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to BrainWave!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement login
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    AppRouter.go(
                      context,
                      RouterNames.registerPage,
                    );
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    AppRouter.go(
                      context,
                      RouterNames.forgotPasswordPage,
                    );
                  },
                  child: const Text('Forgot Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
