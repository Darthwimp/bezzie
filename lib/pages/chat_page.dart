import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/chat_service.dart';
import 'package:bezzie_app/utils/mental_state_analyse.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:bezzie_app/widgets/chat_message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final MentalStateAnalyzer mentalStateAnalyzer = MentalStateAnalyzer();
  final String currentUser = GoogleAuth.user!.uid;

  String? otherUser; // Matched user ID
  bool isLoading = true; // Show loading while fetching match

  @override
  void initState() {
    super.initState();
    _loadMatchedUser();
  }

  /// **1️⃣ Load Matched User from Firestore on App Start**
  Future<void> _loadMatchedUser() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .get();

      if (userDoc.exists) {
        String? matchedUser =
            (userDoc.data() as Map<String, dynamic>)['matchedUser'];
        setState(() {
          otherUser = matchedUser;
        });
      }
    } catch (e) {
      print("Error fetching matched user: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// **2️⃣ Find a match & store it in Firestore**
  Future<void> _findMatch() async {
    setState(() {
      isLoading = true;
    });

    String matchedUserId = await mentalStateAnalyzer.analyzeMentalState();

    if (matchedUserId != "no match found") {
      setState(() {
        otherUser = matchedUserId;
      });

      // Store in Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser)
          .set({
        "matchedUser": matchedUserId,
      }, SetOptions(merge: true));

      await _createChatRoom();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No match found")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  /// **3️⃣ Create Chatroom**
  Future<void> _createChatRoom() async {
    if (otherUser == null) return;

    String chatRoomId = generateChatRoomId(currentUser, otherUser!);

    await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .set({
      "users": [currentUser, otherUser],
      "createdAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  /// Generates a unique chat room ID
  String generateChatRoomId(String userId, String matchedUserId) {
    List<String> ids = [userId, matchedUserId]..sort();
    return "${ids[0]}_${ids[1]}";
  }

  void _sendMessage() async {
    if (messageController.text.isNotEmpty && otherUser != null) {
      await chatService.sendMessage(otherUser!, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BezzieTheme.mainAppGradient(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : (otherUser != null)
                ? SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: StreamBuilder(
                              stream: chatService.getMessages(
                                  currentUser, otherUser!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error: ${snapshot.error}"));
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text("No messages yet"));
                                }
                                return ListView(
                                  children: snapshot.data!.docs
                                      .map((doc) => buildMessageBox(doc))
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextField(
                              controller: messageController,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: Colors.teal.withOpacity(0.25),
                                      width: 2),
                                ),
                                suffixIconColor: Colors.white,
                                suffixIcon: IconButton(
                                  onPressed: _sendMessage,
                                  icon: const Icon(Icons.send),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: _findMatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        "Find a match",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget buildMessageBox(QueryDocumentSnapshot doc) {
    return getChatMessage(
      message: doc['message'],
      email: doc['senderEmail'],
      isUser: doc['senderId'] == currentUser,
    );
  }
}
