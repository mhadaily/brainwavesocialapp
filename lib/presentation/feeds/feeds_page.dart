import 'package:brainwavesocialapp/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../profile/state/profile_state.dart';
import 'feed_state.dart';

class FeedsPage extends ConsumerWidget {
  FeedsPage({super.key});

  final ScrollController scrollController = ScrollController();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserStateProvider);
    final posts = ref.watch(feedStateProvider);

    if (currentUser.isLoading || posts.isLoading) {
      return const CommonPageScaffold(
        title: 'Loading...',
        child: CircularProgressIndicator(),
      );
    }

    if (!currentUser.hasValue || currentUser.hasError) {
      return CommonPageScaffold(
        title: 'Error',
        child: ElevatedButton(
          onPressed: () {
            ref.read(signOutStateProvider);
          },
          child: const Text('You are not logged in!'),
        ),
      );
    }

    return posts.when(
      data: (posts) {
        return CommonPageScaffold(
          title: 'Your Feed',
          leading: TextButton(
            child: UserAvatar(
              photoUrl: currentUser.value!.avatar,
            ),
            onPressed: () {
              AppRouter.go(
                context,
                RouterNames.userProfilePage,
                pathParameters: {
                  'userId': currentUser.value!.uid,
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                _showPostModal(
                  context,
                  controller,
                  () {
                    ref.read(
                      createPostStateProvider(
                        controller.text,
                      ),
                    );
                    AppRouter.go(
                      context,
                      RouterNames.userProfilePage,
                      pathParameters: {
                        'userId': currentUser.value!.uid,
                      },
                    );
                    controller.clear();
                    AppRouter.pop(context);
                  },
                );
              },
            ),
          ],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              if (index == 0) {
                AppRouter.go(context, RouterNames.feedsPage);
              } else if (index == 1) {
                AppRouter.go(context, RouterNames.searchPage);
              } else if (index == 2) {
                AppRouter.go(context, RouterNames.notificationsPage);
              } else if (index == 3) {
                AppRouter.go(context, RouterNames.settingsPage);
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
          child: posts.isEmpty
              ? const Center(
                  child: Text('No Posts Yet! Start following.'),
                )
              : SingleChildScrollView(
                  // physics: const NeverScrollableScrollPhysics(),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: posts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return PostCard(
                        currentUserId: currentUser.value!.uid,
                        post: posts[index],
                        onToggleLike: () {
                          ref.read(
                            togglePostLikeProvider(posts[index].uid),
                          );
                        },
                        onReshare: () {},
                      );
                    },
                  ),
                ),
        );
      },
      loading: () {
        return const CommonPageScaffold(
          title: 'Loading feed...',
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) {
        debugPrint('Error: $error');
        return const CommonPageScaffold(
          title: 'Error',
          child: Text('Error Loading Posts!'),
        );
      },
    );
  }
}

void _showPostModal(
  BuildContext context,
  TextEditingController? controller,
  createPostCallback,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (BuildContext context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Create Post',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              GapWidgets.h16,
              TextField(
                controller: controller,
                maxLines: null,
                minLines: 9,
                decoration: const InputDecoration(
                  hintText: "What's happening?",
                  border: OutlineInputBorder(),
                ),
              ),
              GapWidgets.h16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () async {},
                  ),
                  FilledButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text('Post'),
                    onPressed: createPostCallback,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
