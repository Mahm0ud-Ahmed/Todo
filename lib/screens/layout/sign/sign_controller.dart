import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_task/screens/layout/sign/signable.dart';

class SignController implements Signable {
  static UserCredential _userCredential;

  @override
  static Future<UserCredential> signIn(String email, String password) async {
    try {
      _userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return _userCredential;
  }

  @override
  static Future<UserCredential> signUp(String email, String password) async {
    try {
      _userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return _userCredential;
  }
}
