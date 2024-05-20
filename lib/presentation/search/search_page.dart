import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_state.dart';
import 'users_widget.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchUsers = ref.watch(searchUsersStateProvider);
    final followers = ref.watch(currentUserFollowingsStateProvider);

    return CommonPageScaffold(
      title: 'Search',
      child: searchUsers.when(
        data: (users) {
          return RenderUsers(
            users: users,
            followers: followers.asData != null ? followers.asData!.value : [],
            onFollow: (userId) {
              ref.read(followUserProvider(userId));
            },
            onUnfollow: (userId) {
              ref.read(unfollowUserProvider(userId));
            },
            onNavigateToProfile: (userId) {
              AppRouter.go(
                context,
                RouterNames.userProfilePage,
                pathParameters: {
                  'userId': userId,
                },
              );
            },
          );
        },
        error: (error, _) {
          return Text('Error: $error');
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
