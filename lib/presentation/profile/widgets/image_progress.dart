import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/profile_state.dart';

class DialogProgressBar extends ConsumerWidget {
  const DialogProgressBar({
    super.key,
    required this.metaData,
  });

  final UploadImageMetadata metaData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(uploadProgressProvider(metaData));
    return state.when(
      data: (progress) {
        if (progress == 1.0) {
          AppRouter.pop(context);
        }
        return AlertDialog(
          title: const Text('Uploading...'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: progress,
              ),
              GapWidgets.h16,
              Text(
                '${(progress * 100).toStringAsFixed(2)}%',
              ),
            ],
          ),
        );
      },
      error: (_, __) {
        AppRouter.pop(context);
        return const Text('Error');
      },
      loading: () {
        return const AlertDialog(
          title: Text('Uploading...'),
          content: LinearProgressIndicator(),
        );
      },
    );
  }
}
