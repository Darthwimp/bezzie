import 'package:bezzie_app/firebase_options.dart';
import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/routes.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      splitScreenMode: false,
      builder: (_, i) {
        return MaterialApp(
          theme: BezzieTheme.bezzieTheme(),
          debugShowCheckedModeBanner: false,
          routes: routes,
          initialRoute: (GoogleAuth.user != null) ? '/home' : '/',
        );
      },
    ),
  );
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? _user;
//   @override
//   void initState() {
//     super.initState();
//     _auth.authStateChanges().listen((user) {
//       setState(() {
//         _user = user;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: _user != null ? userInfo() : signInButton());
//   }

//   Widget userInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(
//           width: double.maxFinite,
//         ),
//         Container(
//           height: 200,
//           width: 300,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(
//               Radius.circular(16),
//             ),
//             image:
//                 DecorationImage(image: Image.network(_user!.photoURL!).image),
//           ),
//         ),
//         Text(_user!.email!),
//         ElevatedButton(
//           onPressed: () {
//             _auth.signOut();
//           },
//           child: const Text('Logout'),
//         ),
//       ],
//     );
//   }

//   Widget signInButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: handleGoogleSignIn,
//         child: const Text('Login'),
//       ),
//     );
//   }

//   void handleGoogleSignIn() {
//     try {
//       GoogleAuthProvider googleProvider = GoogleAuthProvider();
//       _auth.signInWithProvider(googleProvider);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
