import 'package:brainwavesocialapp/data/data.dart';
import 'package:flutter/foundation.dart';

@immutable
class Post extends PostDataModel {
  Post({
    required super.uid,
    required super.ownerId,
    required super.content,
    required super.timestamp,
  });

  toDataModel() {
    return PostDataModel(
      uid: super.uid,
      ownerId: super.ownerId,
      content: super.content,
      timestamp: super.timestamp,
    );
  }

  factory Post.fromDataModel(PostDataModel dataModel) {
    return Post(
      uid: dataModel.uid,
      ownerId: dataModel.ownerId,
      content: dataModel.content,
      timestamp: dataModel.timestamp,
    );
  }
}
