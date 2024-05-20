import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brainwavesocialapp/domain/domain.dart';

import '../routing/route_names.dart';
import '../routing/router.dart';
import 'gaps.dart';
import 'post_body.dart';
import 'post_footer.dart';
import 'post_header.dart';
import 'user_avatar.dart';

class PostCard extends ConsumerWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onDelete,
    this.onToggleLike,
    this.onReshare,
    required this.currentUserId,
    this.onTapEnable = true,
  });

  final Post post;
  final bool onTapEnable;
  final String currentUserId;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleLike;
  final VoidCallback? onReshare;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const postOwner = AsyncValue.loading();

    if (postOwner.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (postOwner.hasError) {
      return Text('Error: ${postOwner.error}');
    }

    if (!postOwner.hasValue && postOwner.value == null) {
      return const SizedBox();
    }

    return Card(
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              AppRouter.go(
                context,
                RouterNames.userProfilePage,
                pathParameters: {
                  'userId': postOwner.value!.uid,
                },
              );
            },
            child: UserAvatar(
              photoUrl: postOwner.value!.avatar,
            ),
          ),
          GapWidgets.w8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostHeader(
                  post: post,
                  postOwner: postOwner.value!,
                  currentUserId: currentUserId,
                  onDelete: onDelete,
                ),
                GapWidgets.h8,
                InkWell(
                  onTap: onTapEnable
                      ? () {
                          AppRouter.go(
                            context,
                            RouterNames.postDetailPage,
                            pathParameters: {
                              'postId': post.uid,
                            },
                          );
                        }
                      : null,
                  child: PostBody(post: post),
                ),
                PostFooter(
                  onTapEnable: onTapEnable,
                  postUid: post.uid,
                  onToggleLike: onToggleLike,
                  onReshare: onReshare,
                ),
                GapWidgets.h16
              ],
            ),
          ),
        ],
      ),
    );
  }
}
