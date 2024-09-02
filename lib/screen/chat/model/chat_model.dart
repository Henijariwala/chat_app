class ChatModel {

  String? msg, senderId;
  DateTime? dateTime;

  ChatModel({this.msg,this.dateTime,this.senderId});

  factory ChatModel.mapToModel(Map m1){
    return ChatModel(
      senderId: m1['sendId'],
      msg: m1['msg'],
      dateTime: m1['date']
    );
  }
}
