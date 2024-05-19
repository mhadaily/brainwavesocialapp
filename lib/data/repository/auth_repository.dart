import 'package:brainwavesocialapp/data/data/auth_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interfaces/auth_interface.dart';
import '../models/current_user.dart';

class _AuthRepository implements AuthRepository {
  _AuthRepository(this.authDataSource);

  final AuthRepository authDataSource;

  @override
  Future<CurrentUserDataModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // if you are offline
    // call offline data source
    // if you are online
    return authDataSource.loginWithEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<CurrentUserDataModel> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    // if you are offline
    // call offline data source
    // if you are online
    return authDataSource.registerWithEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<CurrentUserDataModel> loginWithGoogle() {
    return authDataSource.loginWithGoogle();
  }

  @override
  Future<CurrentUserDataModel> loginWithApple() {
    return authDataSource.loginWithApple();
  }

  @override
  Stream<bool> isUserAuthenticated() {
    return authDataSource.isUserAuthenticated();
  }

  @override
  Future<void> signOut() {
    return authDataSource.signOut();
  }
}

final authRepositoryProvider = Provider<_AuthRepository>(
  (ref) => _AuthRepository(
    ref.watch(authRemoteDataSource),
  ),
);
