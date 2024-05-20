import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/storage_source.dart';
import '../interfaces/storage_interface.dart';

class _StorageRepository implements StorageRepository {
  const _StorageRepository(
    this._storageDataSource,
  );

  final StorageRepository _storageDataSource;

  @override
  Future<void> deleteFile(String path) {
    return _storageDataSource.deleteFile(path);
  }

  @override
  Future<String> getDownloadUrl(String path) {
    return _storageDataSource.getDownloadUrl(path);
  }

  @override
  Future<String> uploadFile(String storagePath, File file) {
    return _storageDataSource.uploadFile(storagePath, file);
  }

  @override
  Stream<double> uploadProgress(String path) {
    return _storageDataSource.uploadProgress(path);
  }

  @override
  Future<void> deleteByUrl(String url) {
    return _storageDataSource.deleteByUrl(url);
  }
}

final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) {
    return _StorageRepository(
      ref.read(storageDataSourceProvider),
    );
  },
);
