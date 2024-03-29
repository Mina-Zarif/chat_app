import 'package:chat_app/features/home/data/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  String messagesCol = 'messages';
  FirebaseFirestore database = FirebaseFirestore.instance;

  Stream<QuerySnapshot>? messagesStream;

  void init() async {
    messagesStream = database
        .collection(messagesCol)
        .orderBy('time', descending: false)
        .snapshots();
    emit(Init());
  }

  Future<void> sendMessage(Message message) async {
    debugPrint(message.toJson().toString());
    msgController.clear();
    await database.collection(messagesCol).add(message.toJson());
    chatController.jumpTo(chatController.position.minScrollExtent);
  }

  ScrollController chatController = ScrollController();
  TextEditingController msgController = TextEditingController();

  TextDirection textDirection = TextDirection.ltr;

  void onTextChange(String text) {
    if (text.isEmpty) {
      textDirection = TextDirection.ltr;
      emit(OnTextChange());
      return;
    }
    textDirection = getDirection(text);
    emit(OnTextChange());
  }

  bool checkDirectionality(text) => intl.Bidi.detectRtlDirectionality(text);

  TextDirection getDirection(text) =>
      checkDirectionality(text) ? TextDirection.rtl : TextDirection.ltr;
}
