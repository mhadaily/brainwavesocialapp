import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interfaces/storage_interface.dart';

class StorageDataSource implements StorageRepository {
  StorageDataSource(
    this._storage,
  );

  final FirebaseStorage _storage;

  final Map<String, StreamController<double>> _uploadProgressControllers = {};

  @override
  Stream<double> uploadProgress(String storageFilePath) {
    return _uploadProgressControllers[storageFilePath]?.stream ??
        const Stream.empty();
  }

  @override
  Future<String> uploadFile(
    String storageFilePath,
    File file,
  ) async {
    final ref = _storage.ref().child(storageFilePath);
    final uploadTask = ref.putFile(file);

    // Create a new stream controller for this upload
    final progressController = StreamController<double>.broadcast();
    _uploadProgressControllers[storageFilePath] = progressController;

    // Listen to the upload task's snapshot events
    final listener = uploadTask.snapshotEvents.listen(
      (event) {
        if (event.totalBytes == 0) {
          return;
        }
        final progress = event.bytesTransferred / event.totalBytes;
        progressController.add(progress);
      },
      onError: (error) {
        // Handle errors or close the stream on error
        progressController.addError(error);
        progressController.close();
        _uploadProgressControllers.remove(storageFilePath);
      },
    );

    final snapshot = await uploadTask.whenComplete(
      () {
        progressController.add(1);
        progressController.close();
        _uploadProgressControllers.remove(storageFilePath);
        listener.cancel();
      },
    );
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Future<void> deleteFile(String storageFilePath) {
    final ref = _storage.ref().child(storageFilePath);
    return ref.delete();
  }

  @override
  Future<String> getDownloadUrl(String storageFilePath) {
    final ref = _storage.ref().child(storageFilePath);
    return ref.getDownloadURL();
  }

  // Close all controllers when the data source is disposed
  void dispose() {
    for (var controller in _uploadProgressControllers.values) {
      controller.close();
    }
    _uploadProgressControllers.clear();
  }

  @override
  Future<void> deleteByUrl(String url) {
    final ref = _storage.refFromURL(url);
    return ref.delete();
  }
}

final storageDataSourceProvider = Provider<StorageDataSource>(
  (ref) {
    return StorageDataSource(FirebaseStorage.instance);
  },
);
