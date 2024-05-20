import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/post.dart';

abstract interface class FeedUseCase {
  Stream<List<Post>> getFeedPosts();
  Future<void> createPost(String content);
}

class _FeedUseCase implements FeedUseCase {
  _FeedUseCase(
    this._authRepository,
    this._postRepository,
    this._userRepository,
  );

  final AuthRepository _authRepository;
  final ContentRepository _postRepository;
  final UserRepository _userRepository;

  @override
  Future<void> createPost(content) async {
    final user = _authRepository.currentUser;
    await _postRepository.createPost(
      content: content,
      userId: user.uid,
    );
  }

  @override
  Stream<List<Post>> getFeedPosts() async* {
    // write your own business logic here
    // algorithm to get the feed posts

    final user = _authRepository.currentUser;
    final followings = _userRepository.getFollowings(user.uid);

    await for (final following in followings) {
      if (following != null && following.isNotEmpty) {
        final posts = _postRepository.getFeeds(following).map(
              (event) => event
                  .map(
                    (post) => Post.fromDataModel(post),
                  )
                  .toList(),
            );

        yield* posts;
      }
      yield* Stream.value([]);
    }
  }
}

// 3- Create a provider
final feedUseCaseProvider = Provider<FeedUseCase>(
  (ref) => _FeedUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(postRepositoryProvider),
    ref.watch(userRepositoryProvider),
  ),
);
