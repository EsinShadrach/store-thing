import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // Google Sign In
  signInWithGoogle() async {
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await guser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  createAccountWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }

  // Email And Password Sign In
  signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      }
    }
  }
}
