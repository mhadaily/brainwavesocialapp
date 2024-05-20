import 'package:brainwavesocialapp/data/data.dart';
import 'package:brainwavesocialapp/domain/logics/helpers.dart';
import 'package:flutter/material.dart';

@immutable
class AppUser extends UserInfoDataModel {
  const AppUser({
    required super.uid,
    required super.email,
    super.displayName,
    super.firstName,
    super.lastName,
    super.bio,
    super.photoUrl,
    super.coverImageUrl,
    super.deviceTokens,
  });

  String get id => uid;

  String get name =>
      firstName != null && lastName != null ? '$firstName $lastName' : '???';

  String get avatar => photoUrl ?? 'https://via.placeholder.com/150';
  String get cover => coverImageUrl ?? 'https://via.placeholder.com/600x200';

  String get initials => firstName != null && lastName != null
      ? '${firstName![0]}${lastName![0]}'
      : '?';

  // adding a logic for getting 200x200 thumbnail
  // because we enabled Firebase Extension to generate thumbnail automatically
  String get avatarThumbnail => photoUrl != null
      ? Helpers.getThumbnailFromPhotoUrl(photoUrl)
      : 'https://via.placeholder.com/150';

  toUserInfoDataModel() {
    return UserInfoDataModel(
      firstName: firstName,
      lastName: lastName,
      photoUrl: photoUrl,
      displayName: displayName,
      coverImageUrl: coverImageUrl,
      bio: bio,
      uid: uid,
      email: email,
    );
  }

  factory AppUser.fromUserInfoDataModel(UserInfoDataModel userInfo) {
    return AppUser(
      uid: userInfo.uid,
      email: userInfo.email,
      displayName: userInfo.displayName,
      firstName: userInfo.firstName,
      lastName: userInfo.lastName,
      photoUrl: userInfo.photoUrl,
      coverImageUrl: userInfo.coverImageUrl,
      bio: userInfo.bio,
    );
  }

  factory AppUser.fromCurrentUserDataModel(CurrentUserDataModel userInfo) {
    return AppUser(
      uid: userInfo.uid,
      // since registration is with email only, this is safe
      email: userInfo.email!,
      displayName: userInfo.displayName,
    );
  }
}
