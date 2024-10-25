import 'package:bezzie_app/firebase_options.dart';
import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/routes.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
