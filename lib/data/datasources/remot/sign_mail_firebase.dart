import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// ignore: avoid_classes_with_only_static_members
class SignMailFirebase {
  static Future<Either<String, UserCredential>> signIn({
    @required String email,
    @required String password,
  }) async {
    try {
      return Right(
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left(
          'No user found for that email',
        );
      } else if (e.code == 'wrong-password') {
        return const Left(
          'Wrong password provided for that user',
        );
      } else {
        return Left(e.code);
      }
    }
  }

  static Future<Either<String, UserCredential>> signUp({
    @required String email,
    @required String password,
  }) async {
    try {
      return Right(
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
          'The password provided is too weak',
        );
      } else if (e.code == 'email-already-in-use') {
        return const Left(
          'The account already exists for that email',
        );
      } else {
        return Left(e.code);
      }
    }
  }
}
