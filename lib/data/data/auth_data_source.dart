import 'package:brainwavesocialapp/data/interfaces/auth_interface.dart';
import 'package:brainwavesocialapp/exceptions/app_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/current_user.dart';

class _AuthRemoteDataSource implements AuthRepository {
  _AuthRemoteDataSource(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  @override
  Future<CurrentUserDataModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return CurrentUserDataModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
      );
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CurrentUserDataModel> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return CurrentUserDataModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
      );
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CurrentUserDataModel> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      return CurrentUserDataModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
      );
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CurrentUserDataModel> loginWithApple() async {
    try {
      final provider = AppleAuthProvider()..addScope('email');
      final userCredential = await firebaseAuth.signInWithProvider(
        provider,
      );
      return CurrentUserDataModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        displayName: userCredential.user!.displayName,
      );
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(e.code, e.message ?? 'An error occurred');
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Stream<bool> isUserAuthenticated() {
    return firebaseAuth.authStateChanges().map((user) => user != null);
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }
}

final authRemoteDataSource = Provider<_AuthRemoteDataSource>(
  (ref) => _AuthRemoteDataSource(
    FirebaseAuth.instance,
  ),
);
