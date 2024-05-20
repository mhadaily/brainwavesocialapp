import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class TimestampConverter {
  static DateTime fromJson(Timestamp? timestamp) {
    return timestamp?.toDate() ?? DateTime.now();
  }

  static Timestamp toJson(DateTime? date) =>
      date != null ? Timestamp.fromDate(date) : Timestamp.now();

  static Timestamp toServerTimestamp() {
    return FieldValue.serverTimestamp() as Timestamp;
  }
}
