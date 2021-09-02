import 'package:firebase_auth/firebase_auth.dart';

abstract class Signable {
  static Future<UserCredential> signUp(String email, String password) {}

  static Future<UserCredential> signIn(String email, String password) {}
}
