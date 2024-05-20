import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context, ref) {
    final theme = ref.watch(themeModeProvider);
    return CommonPageScaffold(
      title: 'Settings',
      child: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: theme == ThemeMode.dark,
              onChanged: (value) {
                final theme = ref.read(themeModeProvider.notifier);
                theme.state = value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ),
        ],
      ),
    );
  }
}
