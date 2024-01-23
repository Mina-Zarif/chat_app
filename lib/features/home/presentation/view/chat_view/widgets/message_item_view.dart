import 'package:chat_app/features/home/data/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItemView extends StatelessWidget {
  MessageItemView({super.key, required this.document});

  final DocumentSnapshot document;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Message message = Message.fromJson(data);
    bool isMe = message.senderId == _firebaseAuth.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment:
            (!isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(10),
                bottomRight: const Radius.circular(10),
                topLeft: Radius.circular(isMe ? 10 : 0),
                topRight: Radius.circular(!isMe ? 10 : 0),
              ),
              color: (!isMe) ? Colors.grey.shade200 : Colors.blue[200],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Text(
                  message.message ?? "",
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            DateFormat('jm').format(message.timesTemp!.toDate()),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
