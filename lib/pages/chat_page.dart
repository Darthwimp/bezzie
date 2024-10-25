import 'package:bezzie_app/utils/theme.dart';
import 'package:bezzie_app/widgets/chat_message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BezzieTheme.mainAppGradient(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
      ),
    );
  }
}
