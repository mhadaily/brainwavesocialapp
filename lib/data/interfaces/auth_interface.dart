import '../models/current_user.dart';

abstract interface class AuthRepository {
  Future<CurrentUserDataModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<CurrentUserDataModel> registerWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> forgotPassword(String email);
  Future<CurrentUserDataModel> loginWithGoogle();
  Future<CurrentUserDataModel> loginWithApple();
  Future<void> signOut();
  Stream<bool> isUserAuthenticated();
  bool get isUserAuthenticatedSync;
  CurrentUserDataModel get currentUser;
}
