import 'dart:io';

abstract interface class StorageRepository {
  /// Uploads a file to the storage and returns the download URL
  ///
  /// [storageFilePath] is the path where the file will be stored in the storage
  /// For example, 'avatars/$uid/$name' where $name is the name of the file and
  /// $uid is the user id and 'avatars' is the folder where the file will be stored
  /// $name also contains the extension of the file (e.g. .jpg, .png)
  /// [file] is the file to be uploaded check [File]
  /// Returns the download URL of the uploaded file
  /// Throws an exception if the upload fails
  Future<String> uploadFile(String storageFilePath, File file);

  /// Returns a stream of the upload progress of a file being uploaded to the storage
  ///
  /// [storageFilePath] is the path of the file being uploaded
  /// For example, 'avatars/$uid/$name' where $name is the name of the file and
  /// $uid is the user id and 'avatars' is the folder where the file is stored
  /// $name also contains the extension of the file (e.g. .jpg, .png)
  /// Returns a stream of the upload progress
  /// Throws an exception if the upload progress cannot be retrieved
  /// Returns an empty stream if the upload progress is not available
  Stream<double> uploadProgress(String storageFilePath);

  /// Deletes a file from the storage
  ///
  /// [storageFilePath] is the path of the file to be deleted
  /// For example, 'avatars/$uid/$name' where $name is the name of the file and
  /// $uid is the user id and 'avatars' is the folder where the file is stored
  /// $name also contains the extension of the file (e.g. .jpg, .png)
  /// Throws an exception if the deletion fails
  /// Returns nothing if the deletion is successful
  Future<void> deleteFile(String storageFilePath);

  /// Deletes a file from the storage using the URL of the file
  ///
  /// [url] is the download URL of the file to be deleted
  /// Throws an exception if the deletion fails
  /// Returns nothing if the deletion is successful
  Future<void> deleteByUrl(String url);

  /// Gets the download URL of a file in the storage
  ///
  /// [storageFilePath] is the path of the file in the storage
  /// For example, 'avatars/$uid/$name' where $name is the name of the file and
  /// $uid is the user id and 'avatars' is the folder where the file is stored
  /// $name also contains the extension of the file (e.g. .jpg, .png)
  /// Returns the download URL of the file
  /// Throws an exception if the download URL cannot be retrieved
  Future<String> getDownloadUrl(String storageFilePath);
}
