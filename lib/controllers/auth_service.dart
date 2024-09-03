import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yolda/controllers/gets.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static String verifyId = "";

  static Future<void> registerUser({
    required String username,
    required String surname,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Create user with email and password
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: "$phoneNumber@example.com",
        password: password,
      );

      // Store user data in Firestore
      await _firebaseFirestore.collection('users').doc(phoneNumber).set({
        'username': username,
        'surname': surname,
        'phoneNumber': phoneNumber,
      });
    } catch (e) {
      print("Error registering user: $e");
      rethrow; // Optional: rethrow if you want to handle it elsewhere
    }
  }

  static Future<void> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Attempt to log in with email and password using Firebase Authentication
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: '$phoneNumber@example.com',
        password: password,
      );
      print("User logged in successfully: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      // Throw detailed exceptions based on FirebaseAuthException
      throw AuthException(e.code, e.message!);
    } catch (e) {
      // Handle other exceptions
      throw AuthException('unknown-error', 'An unknown error occurred.');
    }
  }

  static Future<void> sendOtp({
    required String phone,
    // required Function errorStep,
    required Function(String) onCodeSent,
    // required Function nextStep,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 40),
        verificationCompleted: (credential) async {},
        verificationFailed: (e) async {},
        codeSent: (String verificationId, int? forceResendingToken) async {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
      );
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  static Future<String> verifyOTPCode({required String otp}) async {
    try {
      final PhoneAuthCredential cred =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
      final UserCredential user =
          await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success!";
      } else {
        return "Error in OTP login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown error";
    } catch (e) {
      return "Error: $e";
    }
  }

  static Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  static Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser != null;
  }

  static Future<void> onLoginSuccess(BuildContext context, String user) async {
    // Example user ID (usually you would get this from your login logic)
    String userId = user;

    // Get and store the order data
    await Gets.getAndStoreOrderData(userId);

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Login Successful')),
    // );
  }
}

class AuthException implements Exception {
  final String code;
  final String message;

  AuthException(this.code, this.message);

  @override
  String toString() => 'AuthException(code: $code, message: $message)';
}
