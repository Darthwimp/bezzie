import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/mental_state_analyse.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    MentalStateAnalyzer mentalStateAnalyzer = MentalStateAnalyzer();
    return Scaffold(
      body: BezzieTheme.mainAppGradient(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.maxFinite,
            ),
            CircleAvatar(
              maxRadius: 50.r,
              backgroundImage: Image.network(GoogleAuth.user!.photoURL!).image,
            ),
            Gap(24.h),
            Text(
              GoogleAuth.user!.email!.toString(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Member since: "),
                Text(
                  GoogleAuth.user!.metadata.creationTime!.day.toString() + "/",
                ),
                Text(
                  GoogleAuth.user!.metadata.creationTime!.month.toString() +
                      "/",
                ),
                Text(
                  GoogleAuth.user!.metadata.creationTime!.year.toString(),
                ),
              ],
            ),
            Gap(72.h),
            ElevatedButton(
              onPressed: () {
                GoogleAuth.auth.signOut();
                Navigator.pushReplacementNamed(context, "/");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 64.w, vertical: 16.h),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Text(
                'Logout',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
