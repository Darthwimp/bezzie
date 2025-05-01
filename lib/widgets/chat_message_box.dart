import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget getChatMessage(
    {required String message,
    required bool isUser,
    String? email="Bezzie",
    }) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          width: 267.w,
          decoration: BoxDecoration(
            color: isUser ? const Color(0xfe263238) : const Color(0xfe4B8B8F),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: isUser ? Radius.circular(16.r) : const Radius.circular(0),
              bottomRight: isUser ? const Radius.circular(0) : Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (isUser) ? "You" : email!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.41,
                  color: (isUser)
                      ? const Color(0xfe4B8B8F)
                      : const Color(0xfe263238),
                ),
              ),
              Gap(8.h),
              Text(
                message,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -14 * 0.025,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
