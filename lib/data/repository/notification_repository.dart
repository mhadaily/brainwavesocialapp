import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interfaces/notification_interface.dart';

class _NotificationRepository implements NotificationRepository {
  _NotificationRepository(
    this.firebaseMessaging,
    this._onMessage,
    this._onMessageOpenedApp,
  );

  final FirebaseMessaging firebaseMessaging;
  final Stream<RemoteMessage> _onMessage;
  final Stream<RemoteMessage> _onMessageOpenedApp;

  @override
  Future<NotificationSettings> requestPermission() {
    return firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Stream<String> get onTokenRefresh {
    return firebaseMessaging.onTokenRefresh;
  }

  @override
  Future<String?> get token => firebaseMessaging.getToken();

  @override
  Stream<RemoteMessage> get onMessage => _onMessage;

  @override
  Stream<RemoteMessage> get onMessageOpenedApp => _onMessageOpenedApp;
}

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => _NotificationRepository(
    FirebaseMessaging.instance,
    FirebaseMessaging.onMessage,
    FirebaseMessaging.onMessageOpenedApp,
  ),
);
