import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/synapsepx_snackbar.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          GlobalSnackBar.show(
              'The account already exists with a different credential.',
              Colors.red,
              false);
        } else if (e.code == 'invalid-credential') {
          GlobalSnackBar.show(
              'Error occurred while accessing credentials. Try again.',
              Colors.red,
              false);
        }
      } catch (e) {
        GlobalSnackBar.show('Error occurred using Google Sign-In. Try again.',
            Colors.red, false);
      }
    }

    return user;
  }

  //Sign out
  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
    } catch (e) {
      print(e.toString());
    }
  }

  // login in with Username and Password
  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      // On error
      // If user is not found
      if (e.code == 'user-not-found') {
        GlobalSnackBar.show(
            'No user found for the email provided.', Colors.red, false);
      }
      // If password is wrong
      else if (e.code == 'wrong-password') {
        GlobalSnackBar.show(
            'Authentication failed: Wrong password.', Colors.red, false);
      } else {
        GlobalSnackBar.show(e.message.toString(), Colors.red, false);
      }
    }
    return user;
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.synapsepx.patient',
        redirectUri: Uri.parse(
          'https://synapsepx.firebaseapp.com/__/auth/handler',
        ),
      ),
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<String?> getFirebaseIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? token;
    //return FirebaseAuth.instance.currentUser?.getIdToken(true).toString();
    if (user != null) {
      await user.getIdToken(true).then((result) {
        token = result.toString();
      });
    }
    return token;
  }

  Future<String?> getFirebaseUID() async {
    User? user = FirebaseAuth.instance.currentUser;
    var firebaseuid = user?.uid;
    developer.log(firebaseuid.toString());
    return firebaseuid;
  }
}
