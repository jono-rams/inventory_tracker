import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_tracker/models/app_user.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign users in
  static Future<AppUser?> signIn(String email, String password) async {
    try {
      final UserCredential credential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        return AppUser(
          uid: credential.user!.uid,
          email: credential.user!.email!,
        );
      }

      return null;

    } catch (e) {
      return null;
    }
  }

  // log user out
  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}