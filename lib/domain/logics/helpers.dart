import 'dart:io';

import '../entity/image_type.dart';

class Helpers {
  static String getStoragePath(String uid, File file, ImageType type) {
    final name = file.path.split('/').last;
    String storagePath;

    switch (type) {
      case ImageType.cover:
        storagePath = 'covers/$uid/$name';
        break;
      case ImageType.avatar:
        storagePath = 'avatars/$uid/$name';
        break;
    }

    return storagePath;
  }
}
