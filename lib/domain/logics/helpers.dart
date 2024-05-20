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

  static String getThumbnailFromPhotoUrl(photoUrl) {
    // photoUrl = "https://something.com/name.ext?then=something"
    Uri uri = Uri.parse(photoUrl);

    // Get the file name with extension
    String fileNameWithExt = uri.pathSegments.last;

    // Split the file name and extension
    int dotIndex = fileNameWithExt.lastIndexOf('.');
    String name = fileNameWithExt.substring(0, dotIndex);
    String extension = fileNameWithExt.substring(dotIndex);

    // Add _200x200 to the name
    String newNameWithExt = '${name}_200x200$extension';

    // Build the new URI
    Uri newUri = uri.replace(
      pathSegments: [
        ...uri.pathSegments.sublist(0, uri.pathSegments.length - 1),
        newNameWithExt,
      ],
    );

    // Print the new URL
    return newUri.toString();
  }
}
