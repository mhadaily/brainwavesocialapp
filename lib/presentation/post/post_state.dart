import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../../domain/usecases/post_like_usecase.dart';

final getUserInfoStateProvider =
    StreamProvider.autoDispose.family<AppUser?, String>(
  (ref, ownerId) {
    return ref.watch(userUseCaseProvider).getUserInfo(ownerId);
  },
);

final postCommentsCountProvider = FutureProvider.family<int, String>(
  (ref, postId) {
    return ref
        .watch(
          postLikeUseCaseProvider,
        )
        .getPostCommentCount(postId);
  },
);

final getPostCommentsProvider = StreamProvider.family<List<Comment>, String>(
  (ref, postId) {
    return ref
        .watch(
          postDetailUseCaseProvider,
        )
        .getPostComments(
          postId,
        );
  },
);

class CommentPostMetadata {
  CommentPostMetadata({
    required this.postId,
    required this.comment,
    required this.ownerId,
  });

  final String postId;
  final String comment;
  final String ownerId;
}

final postACommentProvider =
    FutureProvider.autoDispose.family<void, CommentPostMetadata>(
  (ref, metadata) async {
    await ref
        .watch(
          postDetailUseCaseProvider,
        )
        .commentPost(
          metadata.postId,
          metadata.ownerId,
          metadata.comment,
        );

    return ref.refresh(
      postCommentsCountProvider(
        metadata.postId,
      ),
    );
  },
);

class CommentDeleteMetadata {
  CommentDeleteMetadata({
    required this.postId,
    required this.commentId,
  });

  final String postId;
  final String commentId;
}

final deleteCommentProvider =
    FutureProvider.autoDispose.family<void, CommentDeleteMetadata>(
  (ref, metadata) async {
    await ref
        .watch(
          postDetailUseCaseProvider,
        )
        .deleteComment(
          metadata.commentId,
          metadata.postId,
        );

    return ref.refresh(
      postCommentsCountProvider(
        metadata.postId,
      ),
    );
  },
);

final postDetailStateProvider = StreamProvider.autoDispose.family<Post, String>(
  (ref, postId) {
    return ref
        .watch(
          postDetailUseCaseProvider,
        )
        .getPostDetail(postId);
  },
);
