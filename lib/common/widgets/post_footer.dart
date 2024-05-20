import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/post/post_state.dart';
import '../../presentation/profile/state/profile_state.dart';

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
    final isPostLiked =
        ref.watch(isPostLikedByCurrentUserProvider(postUid)).valueOrNull ??
            false;
    final postLikesCount =
        ref.watch(postLikesCountProvider(postUid)).valueOrNull ?? 0;

    final postCommentCounts =
        ref.watch(postCommentsCountProvider(postUid)).valueOrNull ?? 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          icon: Icon(
            postCommentCounts != 0
                ? Icons.mode_comment
                : Icons.mode_comment_outlined,
          ),
          label: Text('$postCommentCounts'),
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
            key: ValueKey<int>(postLikesCount),
            icon: Icon(
              isPostLiked ? Icons.favorite : Icons.favorite_border,
            ),
            label: Text('$postLikesCount'),
            onPressed: onToggleLike,
          ),
        ),
      ],
    );
  }
}
