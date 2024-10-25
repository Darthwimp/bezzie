import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatService {
  final dio = Dio();
  final String openAiKey = dotenv.env['OPEN_AI_API_KEY']!;
  List<String> messages = [];
}