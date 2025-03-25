import 'package:bezzie_app/utils/chat_service.dart';
import 'package:bezzie_app/utils/theme.dart';
import 'package:bezzie_app/widgets/user_tile.dart';
import 'package:flutter/material.dart';

class DisplayUsers extends StatelessWidget {
  DisplayUsers({super.key});
  ChatService chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BezzieTheme.mainAppGradient(
        child: buildUSersList(),
      ),
    );
  }

  Widget buildUSersList() {
    return StreamBuilder(
        stream: chatService.getUSersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) Text("Error: ${snapshot.error}");
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => buildUserTile(userData, context))
                .toList(),
          );
        });
  }

  Widget buildUserTile(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      name: userData['email'],
    );
  }
}
