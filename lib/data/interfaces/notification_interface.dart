import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class NotificationRepository {
  Future<NotificationSettings> requestPermission();
  Future<String?> get token;
  Stream<String> get onTokenRefresh;
  Stream<RemoteMessage> get onMessage;
  Stream<RemoteMessage> get onMessageOpenedApp;
}
