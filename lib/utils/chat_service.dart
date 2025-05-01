import 'package:bezzie_app/utils/auth_func.dart';
import 'package:bezzie_app/utils/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String,dynamic>>> getUSersStream(){
    return _firestore.collection('Users').snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(String reciverId, String message) async {
    final String currentUserID = GoogleAuth.user!.uid;
    final String currentUSerEmail = GoogleAuth.user!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserID,
      senderEmail: currentUSerEmail,
      reciverId: reciverId,
      message: message,
      timestamp: timestamp,
    );

    List ids = [currentUserID, reciverId];
    ids.sort();
    String chatroomID = ids.join('_');

    await _firestore
        .collection('chatrooms')
        .doc(chatroomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    List ids = [userID, otherUserID];
    ids.sort();
    String chatroomID = ids.join('_');

    return _firestore
        .collection('chatrooms')
        .doc(chatroomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  
}
