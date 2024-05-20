import 'package:brainwavesocialapp/data/data.dart';

class Comment extends CommentDataModel {
  Comment({
    required super.uid,
    required super.postId,
    required super.ownerId,
    required super.content,
    required super.createdAt,
  });

  String get createdAtString =>
      createdAt?.toLocal().toString().split('.')[0] ?? '';

  toDataModel() {
    return CommentDataModel(
      uid: super.uid,
      postId: super.postId,
      ownerId: super.ownerId,
      content: super.content,
      createdAt: super.createdAt,
    );
  }

  factory Comment.fromDataModel(CommentDataModel dataModel) {
    return Comment(
      uid: dataModel.uid,
      postId: dataModel.postId,
      ownerId: dataModel.ownerId,
      content: dataModel.content,
      createdAt: dataModel.createdAt,
    );
  }

  @override
  String toString() {
    return {
      'uid': super.uid,
      'postId': super.postId,
      'ownerId': super.ownerId,
      'content': super.content,
      'createdAt': super.createdAt,
    }.toString();
  }
}
