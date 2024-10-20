import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                shrinkWrap: true,
                children: [
                  getChatMessage(
                    message: "Hey! Bezzie here...",
                    isUser: false,
                  ),
                  getChatMessage(
                    message: "I need help with my current situation...",
                    isUser: true,
                  ),
                  getChatMessage(
                    message:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra ipsum id mi convallis blandit. Donec at odio non mi eleifend eleifend vel e",
                    isUser: false,
                  ),
                  getChatMessage(
                    message:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    isUser: true,
                  ),
                  getChatMessage(
                    message:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pharetra ipsum id mi convallis blandit. Donec at odio non mi eleifend eleifend vel eu lectus. Ut at nunc congue, accumsan metus ac, commodo velit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consectetur vulputate dui nec lobortis. ",
                    isUser: false,
                  ),
                  getChatMessage(
                    message:
                        "Sed faucibus efficitur lorem sed vehicula. Donec sit amet dolor et neque condimentum laoreet quis non mi. Morbi imperdiet tempus eros, a laoreet erat vestibulum ut.  ",
                    isUser: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getChatMessage({required String message, required bool isUser}) {
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
                bottomLeft: isUser ? Radius.circular(16.r) : Radius.circular(0),
                bottomRight:
                    isUser ? Radius.circular(0) : Radius.circular(16.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUser ? "You" : "Bezzie",
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
}