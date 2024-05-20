import 'package:brainwavesocialapp/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileProvider = StreamProvider.family<AppUser?, String>(
  (ref, uid) {
    return ref.watch(userUseCaseProvider).getUserInfo(uid);
  },
);

final userPostsProvider = FutureProvider.autoDispose.family<List<Post>, String>(
  (ref, uid) {
    return ref
        .watch(
          userUseCaseProvider,
        )
        .getUserPosts(uid);
  },
);

final signOutProvider = FutureProvider.autoDispose(
  (ref) {
    return ref
        .watch(
          userUseCaseProvider,
        )
        .signOut();
  },
);

final deletePostProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, postId) {
    ref.watch(postDetailUseCaseProvider).deletePost(postId);
    final user = ref
        .watch(
          currentUserStateProvider,
        )
        .asData
        ?.value;
    return ref.refresh(
      userPostsProvider(user!.uid),
    );
  },
);

final isPostLikedByCurrentUserProvider = StreamProvider.family<bool, String>(
  (ref, postId) {
    return ref
        .watch(
          postLikeUseCaseProvider,
        )
        .hasCurrentUserLikedPost(postId);
  },
);

final postLikesCountProvider = FutureProvider.family<int, String>(
  (ref, postId) {
    return ref
        .watch(
          postLikeUseCaseProvider,
        )
        .getPostLikesCount(postId);
  },
);

final togglePostLikeProvider = FutureProvider.autoDispose.family<void, String>(
  (ref, postId) async {
    await ref
        .watch(
          postLikeUseCaseProvider,
        )
        .toggleCurrentUserPostLike(
          postId,
        );

    return ref.refresh(postLikesCountProvider(postId));
  },
);

final currentUserStateProvider = StreamProvider.autoDispose<AppUser>(
  (ref) {
    return ref
        .watch(
          userUseCaseProvider,
        )
        .getCurrentUserInfo();
  },
);

final userFollowersCount = FutureProvider.autoDispose.family<int, String>(
  (ref, uid) {
    return ref
        .watch(
          userFollowerUseCaseProvider,
        )
        .getFollowersCount(uid);
  },
);

final userFollowingCount = FutureProvider.autoDispose.family<int, String>(
  (ref, uid) {
    return ref
        .watch(
          userFollowerUseCaseProvider,
        )
        .getFollowingCount(uid);
  },
);

class EditProfileData {
  EditProfileData({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.bio,
  });
  final String uid;
  final String firstName;
  final String lastName;
  final String bio;
}

final editProfileStateProvider =
    FutureProvider.autoDispose.family<void, EditProfileData>(
  (ref, update) {
    return ref
        .watch(
          editProfileUseCaseProvider,
        )
        .editProfile(
          uid: update.uid,
          firstName: update.firstName,
          lastName: update.lastName,
          bio: update.bio,
        );
  },
);

class UploadImageMetadata {
  UploadImageMetadata({
    required this.uid,
    required this.filePath,
    required this.type,
  });

  final String uid;
  final String filePath;
  final ImageType type;
}

final updateImageStateProvider =
    FutureProvider.autoDispose.family<void, UploadImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).updateProfileImage(
          uid: metadata.uid,
          filePath: metadata.filePath,
          type: metadata.type,
        );
  },
);

final uploadProgressProvider =
    StreamProvider.autoDispose.family<double, UploadImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).getUploadProgress(
          uid: metadata.uid,
          filePath: metadata.filePath,
          type: metadata.type,
        );
  },
);

class DeleteImageMetadata {
  DeleteImageMetadata({
    required this.uid,
    required this.imageUrl,
    required this.type,
  });

  final String uid;
  final String imageUrl;
  final ImageType type;
}

final deleteImageStateProvider =
    FutureProvider.autoDispose.family<void, DeleteImageMetadata>(
  (ref, metadata) {
    return ref.watch(editProfileUseCaseProvider).deleteProfileImage(
          uid: metadata.uid,
          imageUrl: metadata.imageUrl,
          type: metadata.type,
        );
  },
);
