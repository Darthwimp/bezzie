import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuth {
  static User? user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static void handleGoogleSignIn() {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    auth.signInWithProvider(googleProvider);
    firestore.collection("users").doc(user!.uid).set({
      "email": user!.email,
      "photoURL": user!.photoURL,
      "uid": user!.uid,
    });
  }
}
