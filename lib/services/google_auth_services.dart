import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _currentUser;

  GoogleAuthService();

  GoogleSignIn get googleSignIn => _googleSignIn;

  Future<User?> get currentUser async {
    User? user = await getUser();
    return user;
  }

  Future<User?> getUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        return authResult.user;
      }
    } catch (error) {
      log('ERROR: ${error.toString()}');
    }
    return null;
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  void signIn() {
    _googleSignIn.signIn();
  }
}
