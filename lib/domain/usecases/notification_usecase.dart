import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/message.dart';

abstract interface class NotificationUseCase {
  Stream<String> onDeviceTokenRefresh();
  Stream<Message> onReceiveMessageWhenOpened();
  Stream<Message> onMessageWhenBackground();
  Future<String?> getDeviceToken();
  Future<void> registerCurrentUserDeviceToken();
}

class _NotificationUseCase implements NotificationUseCase {
  const _NotificationUseCase(
    this._notificationRepository,
    this._userRepository,
    this._authRepository,
  );

  final NotificationRepository _notificationRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  @override
  Future<String?> getDeviceToken() {
    return _notificationRepository.token;
  }

  @override
  Stream<String> onDeviceTokenRefresh() {
    return _notificationRepository.onTokenRefresh;
  }

  @override
  Stream<Message> onMessageWhenBackground() {
    return _notificationRepository.onMessageOpenedApp.map(
      (event) {
        print('event: $event background ');
        return Message.fromDataModel(event);
      },
    );
  }

  @override
  Stream<Message> onReceiveMessageWhenOpened() {
    return _notificationRepository.onMessage.map(
      (event) {
        print('event: $event  ');
        return Message.fromDataModel(event);
      },
    );
  }

  @override
  Future<void> registerCurrentUserDeviceToken() async {
    if (_authRepository.isUserAuthenticatedSync) {
      final token = await _notificationRepository.token;
      final user = _authRepository.currentUser;
      if (token != null) {
        await _userRepository.updateUserDeviceToken(
          user.uid,
          token,
        );
      }
    }
  }
}

final notificationUseCaseProvider = Provider<NotificationUseCase>(
  (ref) => _NotificationUseCase(
    ref.watch(notificationRepositoryProvider),
    ref.watch(userRepositoryProvider),
    ref.watch(authRepositoryProvider),
  ),
);
