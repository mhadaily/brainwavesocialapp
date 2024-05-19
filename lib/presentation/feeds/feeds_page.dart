import 'package:brainwavesocialapp/common/common.dart';
import 'package:brainwavesocialapp/domain/usercases/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedsPage extends ConsumerWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonPageScaffold(
      title: 'Feeds',
      actions: [
        TextButton(
          onPressed: () {
            ref.read(userUseCaseProvider).signOut();
          },
          child: const Text('Logout'),
        )
      ],
      child: const Center(
        child: Text('Feeds'),
      ),
    );
  }
}
