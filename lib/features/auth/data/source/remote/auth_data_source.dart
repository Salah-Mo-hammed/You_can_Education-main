// ignore_for_file: unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/data/models/user_model.dart';

class AuthDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  //! done reset pass
  Future<Either<Failure, Unit>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      print("-----------------${e.code}");
      return Left(
        AuthFailure(e.message ?? "Failed to reset password"),
      );
    } catch (e) {
      return Left(AuthFailure("An unexpected error occurred"));
    }
  }

  //! done log in
  Future<Either<Failure, UserModel>> logInUser(
    String emailAddress,
    String password,
  ) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      final user = credential.user;
      if (user == null) {
        return Left(AuthFailure("login faild , please try again "));
      }
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user.uid).get();
      if (!userDoc.exists) {
        return Left(AuthFailure("User data not found"));
      }
      final userData = userDoc.data() as Map<String, dynamic>;
      final role = userData['role'] ?? 'student';

      bool isCompletedInfo =
          userData['isCompletedInfo'] ??
          false; // fetch bool is completed the info from firestore if it was by any way null ,then its false
      return Right(
        UserModel(
          email: user.email ?? "",
          uid: user.uid,
          isVerified: user.emailVerified,
          role: role,
          isCompletedInfo: isCompletedInfo,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'user-not-found') {
        message = 'Not user found for this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == "invalid-credential") {
        message = 'Wrong email or password ';
      }
      return Left(AuthFailure(message));
    }
  }


  //! done log out func

  Future<Either<Failure, Unit>> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("------------------------------------ sign out is done");
      return const Right(unit);
    } catch (e) {
      return Left(AuthFailure("faild to log out"));
    }
  }
  //! done register func


  Future<Either<Failure, UserModel>> registerUser(
    String emailAddress,
    String password,
    String role,
  ) async {
    try {
      print(
        '*************************************************************************************************************************************************************************************************************************************************************************************************************************************in register user Method ',
      );
      // Create the user
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      final user = credential.user;
      if (user == null) {
        return Left(AuthFailure("User registration failed."));
      }

      // Save user data in Firestore
      await _firestore.collection('Users').doc(user.uid).set({
        'email': emailAddress,
        'userId': user.uid,
        'role': role,
        'isCompletedInfo': false,
      });

      // Send email verification
      try {
        await user.sendEmailVerification();
        print(" Email verification sent to ${user.email}");
      } catch (e) {
        print(" Failed to send email verification: $e");
      }

      // Fetch user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('Users').doc(user.uid).get();

      if (!userDoc.exists) {
        return Left(AuthFailure("User Data Not Found"));
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final fetchData = userData['role'] ?? 'student';

      return Right(
        UserModel(
          uid: user.uid,
          email: user.email ?? "",
          isVerified: user.emailVerified,
          role: fetchData,
          isCompletedInfo: role == "Trainers" ? true : false,
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(AuthFailure(message));
    }
  }
}
