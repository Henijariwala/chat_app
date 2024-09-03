import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {

  String? msg, senderId;
  Timestamp? dateTime;
  String? docId;

  ChatModel({this.msg,this.dateTime,this.senderId});

  factory ChatModel.mapToModel(Map m1){
    return ChatModel(
      senderId: m1['sendId'],
      msg: m1['msg'],
      dateTime: m1['date']
    );
  }
}
