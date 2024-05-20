import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract interface class EditProfileUseCase {
  Future<void> editProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
  });
}

class _EditProfileUseCase implements EditProfileUseCase {
  const _EditProfileUseCase(
    this._userRepository,
  );

  final UserRepository _userRepository;

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
}

final editProfileUseCaseProvider = Provider<EditProfileUseCase>(
  (ref) => _EditProfileUseCase(
    ref.watch(userRepositoryProvider),
  ),
);
