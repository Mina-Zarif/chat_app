import 'package:chat_app/features/home/data/logic/chat_service.dart';
import 'package:chat_app/features/home/presentation/view/chat_view/widgets/message_item_view.dart';
import 'package:chat_app/features/home/presentation/view/chat_view/widgets/typing_text_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  ChatView({
    super.key,
    required this.receiverEmail,
    required this.receiverUid,
  });

  final String receiverEmail;
  final String receiverUid;

  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        receiverId: receiverUid,
        message: messageController.text,
      );
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          TypingTextBar(
            messageController: messageController,
            onSend: () => sendMessage(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        userId: _firebaseAuth.currentUser!.uid,
        otherUserId: receiverUid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Oops, Theres's an error"));
        }
        if (snapshot.hasData) {
          return ListView(
              children: snapshot.data!.docs
                  .map((e) => MessageItemView(document: e))
                  .toList());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
