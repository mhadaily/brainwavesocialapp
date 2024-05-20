import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/comment.dart';
import '../profile/state/profile_state.dart';
import 'post_state.dart';

class PostDetailPage extends ConsumerWidget {
  const PostDetailPage({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postDetailStateProvider(postId));
    final postComments = ref.watch(getPostCommentsProvider(postId));
    final currentUser = ref.watch(currentUserStateProvider);

    if (post.isLoading || postComments.isLoading || currentUser.isLoading) {
      return const CommonPageScaffold(
        title: 'Loading',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (post.hasError || postComments.hasError || currentUser.hasError) {
      return CommonPageScaffold(
        title: 'Error',
        child: Text('Error: ${post.error}'),
      );
    }

    final postOwner = ref.watch(getUserInfoStateProvider(post.value!.ownerId));

    if (postOwner.hasError) {
      return CommonPageScaffold(
        title: 'Error',
        child: Text('Error: ${postOwner.error}'),
      );
    }

    if (postOwner.isLoading) {
      return const CommonPageScaffold(
        title: 'Loading',
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final comments = postComments.value!;

    return CommonPageScaffold(
      title: 'Post Detail',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostCard(
                    onTapEnable: false,
                    currentUserId: currentUser.value!.uid,
                    post: post.value!,
                  ),
                  for (final comment in comments)
                    Consumer(
                      builder: (context, ref, child) {
                        return CommentBody(
                          comment: comment,
                        );
                      },
                    ),
                  GapWidgets.h48
                ],
              ),
            ),
          ),
          CommentForm(
            postId: postId,
            onPostComment: (commentContent) {
              ref.read(
                postACommentProvider(
                  CommentPostMetadata(
                    postId: postId,
                    comment: commentContent,
                    ownerId: currentUser.value!.uid,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CommentBody extends ConsumerWidget {
  const CommentBody({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentOwner = ref.watch(getUserInfoStateProvider(comment.ownerId));
    final currentUser = ref.watch(currentUserStateProvider);
    return commentOwner.when(
      data: (appUser) {
        if (appUser == null) {
          return const Text('Error: User is not found!');
        }
        return Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  AppRouter.go(
                    context,
                    RouterNames.userProfilePage,
                    pathParameters: {
                      'userId': appUser.uid,
                    },
                  );
                },
                child: UserAvatar(
                  photoUrl: appUser.avatar,
                ),
              ),
              title: Text(appUser.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.content),
                  const SizedBox(height: 8),
                  Text(
                    comment.createdAtString,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              trailing: currentUser.value?.uid == comment.ownerId
                  ? IconButton(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () {
                        ref.read(
                          deleteCommentProvider(
                            CommentDeleteMetadata(
                              postId: comment.postId,
                              commentId: comment.uid,
                            ),
                          ),
                        );
                      },
                    )
                  : null,
            ),
            const Divider(),
          ],
        );
      },
      error: (_, __) {
        return const SizedBox();
      },
      loading: () {
        return const Text('Loading...');
      },
    );
  }
}

class CommentForm extends StatefulWidget {
  const CommentForm({
    super.key,
    required this.postId,
    required this.onPostComment,
  });

  final String postId;
  final void Function(String) onPostComment;

  @override
  CommentFormState createState() => CommentFormState();
}

class CommentFormState extends State<CommentForm> {
  final _controller = TextEditingController();
  final _maxChars = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _controller,
          style: Theme.of(context).textTheme.bodySmall,
          // maximum length of the text field
          maxLength: _maxChars,
          // Allows the text field to expand vertically
          maxLines: null,
          // Multiline text field
          keyboardType: TextInputType.multiline,
          // Limit the number of characters
          inputFormatters: [
            // This is a built-in formatter that limits the number of characters
            LengthLimitingTextInputFormatter(
              _maxChars,
            ),
          ],
          decoration: const InputDecoration(
            hintText: "Enter your text here",
            border: OutlineInputBorder(),
          ),
        ),
        TextButton(
          onPressed: () {
            // Trigger comment submission
            final commentContent = _controller.text;
            if (commentContent.isNotEmpty) {
              widget.onPostComment(commentContent);
            }
            // handle clear the text field
            // if successfully posted
            // for now, let's just clear the text field
            _controller.clear();
          },
          child: const Text('Post Comment'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
