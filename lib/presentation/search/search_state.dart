import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../feeds/feed_state.dart';

final searchUsersStateProvider = FutureProvider.autoDispose<List<AppUser>>(
  (ref) {
    return ref.watch(searchUseCaseProvider).searchUsers();
  },
);

final currentUserFollowingsStateProvider =
    StreamProvider.autoDispose<List<String>>(
  (ref) {
    return ref
        .watch(
          userFollowerUseCaseProvider,
        )
        .getCurrentUserFollowings();
  },
);

final followUserProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, userId) async {
    await ref.watch(userFollowerUseCaseProvider).followUser(userId);
    return ref.refresh(feedStateProvider);
  },
);

final unfollowUserProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, userId) async {
    await ref.watch(userFollowerUseCaseProvider).unFollowUser(userId);
    return ref.refresh(feedStateProvider);
  },
);
