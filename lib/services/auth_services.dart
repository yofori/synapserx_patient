import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synapserx_patient/widgets/synapsepx_snackbar.dart';

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
              context,
              'The account already exists with a different credential.',
              Colors.red,
              false);
        } else if (e.code == 'invalid-credential') {
          GlobalSnackBar.show(
              context,
              'Error occurred while accessing credentials. Try again.',
              Colors.red,
              false);
        }
      } catch (e) {
        GlobalSnackBar.show(
            context,
            'Error occurred using Google Sign-In. Try again.',
            Colors.red,
            false);
      }
    }

    return user;
  }

  //Sign out
  static Future<void> signOut({required BuildContext context}) async {
    try {
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
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
        GlobalSnackBar.show(context, 'No user found for the email provided.',
            Colors.red, false);
      }
      // If password is wrong
      else if (e.code == 'wrong-password') {
        GlobalSnackBar.show(context, 'Authentication failed: Wrong password.',
            Colors.red, false);
      } else {
        GlobalSnackBar.show(context, e.message.toString(), Colors.red, false);
      }
    }
    return user;
  }
}
