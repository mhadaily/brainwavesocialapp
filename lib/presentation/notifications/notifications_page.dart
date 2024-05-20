import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CommonPageScaffold(
      title: 'Notifications',
      child: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
