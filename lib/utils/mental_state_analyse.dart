import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class MentalStateAnalyzer {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Dio dio = Dio();
  final String pythonApiEndpoint = "https://cheerful-fish-slowly.ngrok-free.app/analyze-mental-state";

  Future<String> analyzeMentalState() async {
    final user = auth.currentUser;
    final querySnapshot = await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("chats")
        .orderBy("timestamp", descending: false)
        .get();

    String chatHistory = querySnapshot.docs.map((doc) {
      return (doc["isUser"] ? "User: " : "Bot: ") + doc["text"];
    }).join("\n");

    try {
      final response = await dio.post(
        pythonApiEndpoint,
        data: {
            "id": user.uid,
            "chat_history": chatHistory
          },
      );
      if (response.statusCode == 200) {
        return response.data['most_similar_user'].toString();
      }
    } catch (e) {
      print("Error sending data to API: $e");
    }
    return "no match found";
  }
}
