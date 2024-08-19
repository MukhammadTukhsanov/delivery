import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static String verifyId = "";

  static Future registerUser(
      {required phoneNumber,
      required username,
      required surname,
      required password}) async {
    // create user with emmail and password
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: phoneNumber + "@example.com", password: password);

    //  Store user data in Firestore

    await _firebaseFirestore.collection('users').doc(phoneNumber).set({
      'username': username,
      'surname': surname,
      'password': password,
      'phoneNumber': phoneNumber
    });
  }

  static Future loginUser({required phoneNumber, required password}) async {
    try {
      DocumentSnapshot userDoc =
          await _firebaseFirestore.collection('users').doc(phoneNumber).get();

      if (userDoc.exists) {
        if (userDoc['password'] == password) {
          await _firebaseAuth.signInWithEmailAndPassword(
              email: phoneNumber + '@example.com', password: password);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future sendOtp(
      {required String phone,
      required Function errorStep,
      required Function nextStep}) async {
    await _firebaseAuth
        .verifyPhoneNumber(
            timeout: const Duration(seconds: 30),
            phoneNumber: phone,
            verificationCompleted: (phoneAuthCredential) async {
              return;
            },
            verificationFailed: (error) async {
              return;
            },
            codeSent: (verificationId, forceResendingToken) async {
              verifyId = verificationId;
              nextStep();
            },
            codeAutoRetrievalTimeout: (verificationId) async {
              return;
            })
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  // verify the otp code and login

  static Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success!";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // to logout the user
  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
