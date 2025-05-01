import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:bezzie_app/widgets/chat_message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final String openAiApiEndpointSendMessage =
      "https://cheerful-fish-slowly.ngrok-free.app/send-message";
  final dio = Dio();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    final user = GoogleAuth.user;
    firestore
        .collection("users")
        .doc(user!.uid)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          messages = snapshot.docs.map((doc) => doc.data()).toList();
        });
      }
      if(snapshot.docs.isEmpty) {
        setState(() {
          messages = [
            {
              "text": "Hello! How can I assist you today?",
              "isUser": false,
            },
          ];
        });
      }
    });
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final user = GoogleAuth.user;
    final chatRef = firestore.collection("users").doc(user!.uid).collection("chats");
    await chatRef.add({
      "text": message,
      "isUser": true,
      "timestamp": FieldValue.serverTimestamp(),
    });
    controller.clear();
    try {
      final res = await dio.post(
        openAiApiEndpointSendMessage,
        data: {
          "query": message,
        },
      );
      if (res.statusCode == 200) {
        final resData = res.data['response'].toString();
        await chatRef.add({
          "text": resData,
          "isUser": false,
          "timestamp": FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BezzieTheme.mainAppGradient(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: ListView.builder(
                  itemCount: messages.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemBuilder: (context, index) {
                    return getChatMessage(
                        message: messages[index]['text'],
                        isUser: messages[index]['isUser']);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 8.h, left: 16.w, right: 16.w),
                  child: TextField(
                    controller: controller,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: Colors.teal.withOpacity(0.25),
                          width: 2.sp,
                        ),
                      ),
                      suffixIconColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          sendMessage(controller.text);
                        },
                        icon: const Icon(
                          Icons.send,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
