import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? senderId;
  String? senderEmail;
  String? receiverId;
  String? message;
  Timestamp? timesTemp;

  Message({
    this.senderId,
    this.senderEmail,
    this.receiverId,
    this.timesTemp,
    this.message,
  });

  Message.fromJson(dynamic json) {
    senderId = json['sender_id'];
    senderEmail = json['sender_email'];
    receiverId = json['receiver_id'];
    message = json['message'];
    timesTemp = json['timestamp'];
  }

  // Timestamp.fromDate(DateTime.parse(timestampString))
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_id'] = senderId;
    map['sender_email'] = senderEmail;
    map['receiver_id'] = receiverId;
    // map['receiver_email'] = receiverEmail;
    map['message'] = message;
    map['timestamp'] = timesTemp;
    return map;
  }
}
