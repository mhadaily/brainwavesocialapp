import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/common.dart';
import 'state/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info.dart';

class UserProfilePage extends ConsumerWidget {
  const UserProfilePage({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestedUser = ref.watch(userProfileProvider(userId));
    final userPosts = ref.watch(userPostsProvider(userId));
    final currentUser = ref.watch(currentUserStateProvider).valueOrNull;
    final followers = ref.watch(userFollowersCount(userId)).valueOrNull ?? 0;
    final following = ref.watch(userFollowingCount(userId)).valueOrNull ?? 0;

    if (currentUser == null) {
      return const CommonPageScaffold(
        title: 'NotFound',
        child: Text('You are not logged in!'),
      );
    }

    return requestedUser.when(
      data: (user) {
        if (user == null) {
          return const CommonPageScaffold(
            title: 'NotFound',
            child: Text('User Not Found!'),
          );
        }
        return CommonPageScaffold(
          title: user.name,
          actions: userId == user.uid
              ? [
                  IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () {
                      ref.read(signOutProvider);
                    },
                  ),
                ]
              : null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(
                  coverImageUrl: user.cover,
                  profileImageUrl: user.avatar,
                  uid: user.uid,
                  currentUserId: currentUser.uid,
                ),
                ProfileInfo(
                  name: user.name,
                  email: user.email,
                  bio: user.bio,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('$following Following'),
                    Text('$followers Followers'),
                  ],
                ),
                const Divider(),
                GapWidgets.h24,
                if (userPosts.isLoading) const CircularProgressIndicator(),
                if (userPosts.hasError) const Text('Error Loading Posts!'),
                if (userPosts.hasValue &&
                    userPosts.value != null &&
                    userPosts.value!.isEmpty)
                  const Text('No Posts Yet!'),
                if (userPosts.hasValue && userPosts.value != null)
                  for (int i = 0; i < userPosts.value!.length; i++)
                    PostCard(
                      currentUserId: currentUser.uid,
                      post: userPosts.value![i],
                      onToggleLike: () {
                        ref.read(
                          togglePostLikeProvider(userPosts.value![i].uid),
                        );
                      },
                      onReshare: () {},
                      onDelete: () {
                        ref.read(
                          deletePostProvider(userPosts.value![i].uid),
                        );
                      },
                    ),
              ],
            ),
          ),
        );
      },
      error: (error, _) {
        return CommonPageScaffold(
          title: 'Error',
          child: Text('Error: $error'),
        );
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
