import 'package:brainwavesocialapp/data/data.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/convertors.dart';

part 'post.g.dart';

@JsonSerializable()
class PostDataModel {
  PostDataModel({
    required this.uid,
    required this.ownerId,
    this.location,
    required this.content,
    required this.timestamp,
    this.photoUrl,
  });

  @JsonKey(includeToJson: false)
  final String uid;

  final String ownerId;
  final String? location;
  final String content;
  final String? photoUrl;

  @JsonKey(
    fromJson: TimestampConverter.fromJson,
    toJson: TimestampConverter.toJson,
  )
  final DateTime timestamp;

  factory PostDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    _,
  ) {
    final data = snapshot.data()!;
    return PostDataModel.fromJson({
      ...data,
      'uid': snapshot.id,
    });
  }

  factory PostDataModel.fromJson(Map<String, dynamic> json) =>
      _$PostDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataModelToJson(this);
}
