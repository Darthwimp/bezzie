import 'package:bezzie_app/utils/theme.dart';
import 'package:bezzie_app/widgets/chat_message_box.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final String openAiEndpoint = "https://api.openai.com/v1/chat/completions";
  final String openAiKey = dotenv.env['OPEN_AI_API_KEY']!;
  final dio = Dio();
  final TextEditingController controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hey! Bezzie here this side. How may I assist you today?",
      "isUser": false,
    }
  ];

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    if (message.isNotEmpty) {
      setState(() {
        messages.add({
          "text": message,
          "isUser": true,
        });
      });
    }
    controller.clear();

    try {
      final res = await dio.post(
        openAiEndpoint,
        data: {
          "model": "gpt-4-turbo",
          "messages": [
            {"role": "user", "content": message}
          ],
          "max_tokens": 100,
          "temperature": 0.7
        },
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            "Authorization": "Bearer $openAiKey",
            "Content-Type": "application/json"
          },
        ),
      );
      if (res.statusCode == 200) {
        final resData = res.data;
        final botMessage = resData['choices'][0]['message']['content'];
        setState(() {
          messages.add({
            "text": botMessage,
            "isUser": false,
          });
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
                flex: 10,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
