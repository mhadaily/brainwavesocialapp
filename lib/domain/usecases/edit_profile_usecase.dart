import 'dart:io';

import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/image_type.dart';
import '../logics/helpers.dart';

abstract interface class EditProfileUseCase {
  Future<void> editProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  });
  Future<void> updateProfileImage({
    required String uid,
    required String filePath,
    required ImageType type,
  });
  Stream<double> getUploadProgress({
    required String uid,
    required String filePath,
    required ImageType type,
  });
  Future<void> deleteProfileImage({
    required String uid,
    required String imageUrl,
    required ImageType type,
  });
}

class _EditProfileUseCase implements EditProfileUseCase {
  const _EditProfileUseCase(
    this._userRepository,
    this._storageRepository,
  );

  final UserRepository _userRepository;
  final StorageRepository _storageRepository;

  @override
  Future<void> editProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  }) {
    return _userRepository.editUserProfile(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      bio: bio,
    );
  }

  @override
  Future<void> updateProfileImage({
    required String uid,
    required String filePath,
    required ImageType type,
  }) async {
    final file = File(filePath);
    final storagePath = Helpers.getStoragePath(uid, file, type);

    final uploadFuture = _storageRepository.uploadFile(storagePath, file);

    final downloadUrl = await uploadFuture;

    switch (type) {
      case ImageType.cover:
        await _userRepository.updateCoverImage(
          uid: uid,
          coverImageUrl: downloadUrl,
        );
        break;
      case ImageType.avatar:
        await _userRepository.updateAvatarImage(
          uid: uid,
          // todo: replace with thumbnail _200x200
          // Check [Helpers.getThumbnailFromPhotoUrl]
          // check lib/domain/entity/user.dart
          photoUrl: downloadUrl,
        );
        break;
    }
  }

  @override
  Stream<double> getUploadProgress({
    required String uid,
    required String filePath,
    required ImageType type,
  }) {
    final file = File(filePath);
    final storagePath = Helpers.getStoragePath(uid, file, type);
    return _storageRepository.uploadProgress(storagePath);
  }

  @override
  Future<void> deleteProfileImage({
    required String uid,
    required String imageUrl,
    required ImageType type,
  }) async {
    await _storageRepository.deleteByUrl(imageUrl);

    switch (type) {
      case ImageType.cover:
        await _userRepository.updateCoverImage(uid: uid, coverImageUrl: null);
        break;
      case ImageType.avatar:
        await _userRepository.updateAvatarImage(uid: uid, photoUrl: null);
        break;
    }
  }
}

final editProfileUseCaseProvider = Provider<EditProfileUseCase>(
  (ref) => _EditProfileUseCase(
    ref.watch(userRepositoryProvider),
    ref.watch(storageRepositoryProvider),
  ),
);
