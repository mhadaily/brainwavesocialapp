import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/profile/state/profile_state.dart';
import '../routing/route_names.dart';
import '../routing/router.dart';

class PostFooter extends ConsumerWidget {
  const PostFooter({
    super.key,
    required this.postUid,
    required this.onTapEnable,
    this.onReshare,
    this.onToggleLike,
  });

  final String postUid;
  final bool onTapEnable;
  final VoidCallback? onReshare;
  final VoidCallback? onToggleLike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const isPostLiked = false;
    const postLikesCount = 0;

    const postCommentCounts = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          icon: const Icon(
            postCommentCounts != 0
                ? Icons.mode_comment
                : Icons.mode_comment_outlined,
          ),
          label: const Text('$postCommentCounts'),
          onPressed: onTapEnable
              ? () {
                  AppRouter.go(
                    context,
                    RouterNames.postDetailPage,
                    pathParameters: {
                      'postId': postUid,
                    },
                  );
                }
              : null,
        ),
        TextButton.icon(
          icon: const Icon(Icons.repeat),
          label: const Text('0'),
          onPressed: onReshare,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
          ) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: TextButton.icon(
            key: const ValueKey<int>(postLikesCount),
            icon: const Icon(
              isPostLiked ? Icons.favorite : Icons.favorite_border,
            ),
            label: const Text('$postLikesCount'),
            onPressed: onToggleLike,
          ),
        ),
      ],
    );
  }
}
