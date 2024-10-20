import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuth{
  static User? user;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static void handleGoogleSignIn(){
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      auth.signInWithProvider(googleProvider);
    } catch (e) {
      print(e.toString());
    }
  }
}