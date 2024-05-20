import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_data_source.dart';
import '../data/user_data_source.dart';
import '../interfaces/auth_interface.dart';
import '../interfaces/user_interface.dart';
import '../models/current_user.dart';
import '../models/userinfo.dart';

class _AuthRepository implements AuthRepository {
  _AuthRepository(
    this._authDataSource,
    this._userDataSource,
  );

  final AuthRepository _authDataSource;
  final UserRepository _userDataSource;

  @override
  Future<CurrentUserDataModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _authDataSource.loginWithEmailPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<CurrentUserDataModel> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final user = await _authDataSource.registerWithEmailPassword(
      email: email,
      password: password,
    );

    // Create user profile
    await _userDataSource.createUser(
      UserInfoDataModel(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
      ),
    );

    return user;
  }

  @override
  Future<void> signOut() {
    return _authDataSource.signOut();
  }

  @override
  forgotPassword(String email) {
    return _authDataSource.forgotPassword(
      email,
    );
  }

  @override
  Future<CurrentUserDataModel> loginWithApple() {
    return _authDataSource.loginWithApple();
  }

  @override
  Future<CurrentUserDataModel> loginWithGoogle() {
    return _authDataSource.loginWithGoogle();
  }

  @override
  Stream<bool> isUserAuthenticated() {
    return _authDataSource.isUserAuthenticated();
  }

  @override
  CurrentUserDataModel get currentUser => _authDataSource.currentUser;

  @override
  bool get isUserAuthenticatedSync => _authDataSource.isUserAuthenticatedSync;
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => _AuthRepository(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(userDataSourceProvider),
  ),
);
