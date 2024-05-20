// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentDataModel _$CommentDataModelFromJson(Map<String, dynamic> json) =>
    CommentDataModel(
      uid: json['uid'] as String,
      postId: json['postId'] as String,
      ownerId: json['ownerId'] as String,
      content: json['content'] as String,
      createdAt: TimestampConverter.fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$CommentDataModelToJson(CommentDataModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'ownerId': instance.ownerId,
      'content': instance.content,
      'createdAt': TimestampConverter.toJson(instance.createdAt),
    };
