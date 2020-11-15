import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:knebelknotes/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<bool> get appleSignInAvailable => AppleSignIn.isAvailable();

  // create user obj based on firebase user
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid, email: user.email) : null;
  }

  //auth change user stream
  Stream<CustomUser> get user {
    print(_auth.authStateChanges().map(_userFromFirebaseUser));
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //Sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithApple() async {
    try {

      final AuthorizationResult appleResult =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (appleResult.status) {
        case AuthorizationStatus.authorized:
          final oAuthProvider = OAuthProvider('apple.com');
          final AuthCredential credential = oAuthProvider.credential(
              accessToken: String.fromCharCodes(
                  appleResult.credential.authorizationCode),
              idToken:
                  String.fromCharCodes(appleResult.credential.identityToken));

          final UserCredential result =
              await _auth.signInWithCredential(credential);
          User user = result.user;

          return _userFromFirebaseUser(user);
          break;
        case AuthorizationStatus.error:
        print('Error');
        break;
        case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;

      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final UserCredential result =
          await _auth.signInWithCredential(credential);
      User user = result.user;

      //Create a new document for the user with the uid and email

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}


class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;
  
  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}