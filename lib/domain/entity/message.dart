import 'package:firebase_messaging/firebase_messaging.dart';

class Message {
  Message({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  factory Message.fromDataModel(RemoteMessage message) {
    return Message(
      title: message.notification?.title ?? 'Notification',
      body: message.notification?.body ?? 'Missing Info!',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Message && other.title == title && other.body == body;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode;

  @override
  String toString() => {
        'title': title,
        'body': body,
      }.toString();
}
