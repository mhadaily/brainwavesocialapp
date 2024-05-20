import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/convertors.dart';

part 'comment.g.dart';

@JsonSerializable()
class CommentDataModel {
  CommentDataModel({
    required this.uid,
    required this.postId,
    required this.ownerId,
    required this.content,
    this.createdAt,
  });

  @JsonKey(includeToJson: false)
  final String uid;

  final String postId;
  final String ownerId;
  final String content;

  @JsonKey(
    fromJson: TimestampConverter.fromJson,
    toJson: TimestampConverter.toJson,
  )
  final DateTime? createdAt;

  factory CommentDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    _,
  ) {
    final data = snapshot.data()!;

    return CommentDataModel.fromJson({
      ...data,
      'uid': snapshot.id,
    });
  }

  factory CommentDataModel.fromJson(Map<String, dynamic> json) =>
      _$CommentDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataModelToJson(this);
}
