import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential> loginWithEmail(String email, String password) {
  return FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
