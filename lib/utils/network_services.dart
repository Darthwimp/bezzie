import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkServices {
  final Dio dio = Dio();
  final String openAiApiEndpointSendMessage = "https://cheerful-fish-slowly.ngrok-free.app/send-message";
  //make a post request
  Future<String> sendMessage(String message)async{
    Response response = await dio.post(
      openAiApiEndpointSendMessage,
      data: {
        "query": message,
      },
    );
    return response.data['response'].toString();
  }
}