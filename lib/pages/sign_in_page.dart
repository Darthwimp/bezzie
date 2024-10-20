import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    GoogleAuth.auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          GoogleAuth.user = user;
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget signInButton(
        {required IconData icon, required String text, Color? color}) {
      return ElevatedButton(
        onPressed: () {
          GoogleAuth.handleGoogleSignIn();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
          backgroundColor: color ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: Colors.black,
            ),
            Gap(8.w),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: BezzieTheme.mainAppGradient(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.maxFinite,
            ),
            Image.asset("assets/images/bezzie 6.png"),
            Text(
              "Share without fear...",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Connect without judgement",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(167.h),
            signInButton(
              icon: (FontAwesomeIcons.google),
              text: "Sign in with Google",
              color: const Color(0xfeDBFFFC),
            ),
          ],
        ),
      ),
    );
  }
}
