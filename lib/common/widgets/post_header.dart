import 'package:flutter/material.dart';

import '../../domain/entity/post.dart';
import '../../domain/entity/user.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.post,
    this.postOwner,
    required this.currentUserId,
    this.onDelete,
  });

  final Post post;
  final AppUser? postOwner;
  final String currentUserId;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postOwner?.name ?? 'unknown',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (post.location != null)
                Text(
                  post.location!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ),
        if (postOwner != null &&
            postOwner!.uid == currentUserId &&
            onDelete != null)
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_forever_outlined,
            ),
          ),
      ],
    );
  }
}
