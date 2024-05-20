// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDataModel _$PostDataModelFromJson(Map<String, dynamic> json) =>
    PostDataModel(
      uid: json['uid'] as String,
      ownerId: json['ownerId'] as String,
      location: json['location'] as String?,
      content: json['content'] as String,
      timestamp: TimestampConverter.fromJson(json['timestamp'] as Timestamp?),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$PostDataModelToJson(PostDataModel instance) =>
    <String, dynamic>{
      'ownerId': instance.ownerId,
      'location': instance.location,
      'content': instance.content,
      'photoUrl': instance.photoUrl,
      'timestamp': TimestampConverter.toJson(instance.timestamp),
    };
