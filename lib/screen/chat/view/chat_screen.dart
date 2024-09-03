import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled5/screen/chat/controller/chat_controller.dart';
import 'package:untitled5/screen/chat/model/chat_model.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/auth_helper.dart';
import 'package:untitled5/utils/firedb_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController txtChat = TextEditingController();
  ProfileModel model=Get.arguments;
  ChatController controller = Get.put(ChatController());
  @override
  void initState() {
    controller.getChat();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name}"),
        leading: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            child: Text(model.name![0]),
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: controller.dataSnap,
            builder:(context, snapshot) {
              if(snapshot.hasError){
                return Text("${snapshot.error}");
              }else if(snapshot.hasData){
                List<ChatModel> chatList = [];
                QuerySnapshot? snap = snapshot.data;

                for(var x in  snap!.docs){
                  Map m1 = x.data() as Map;
                  ChatModel c1 = ChatModel.mapToModel(m1);
                  c1.docId = x.id;
                  chatList.add(c1);
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        margin: const EdgeInsets.all(5),
                        width: 200,
                        alignment: chatList[index].senderId != AuthHelper.helper.user!.uid
                            ?Alignment.centerLeft
                            : Alignment.centerRight,
                        child: InkWell(
                          onLongPress: () {

                            if(chatList[index].senderId == AuthHelper.helper.user!.uid){
                              Get.defaultDialog(
                                title: "You want to delete msg",
                                actions: [
                                  TextButton(onPressed: () async {
                                   await FireDbHelper.helper.deleteChat(chatList[index].docId!);
                                    Get.back();
                                  }, child: const Text("yes")),
                                  TextButton(onPressed: () {
                                    Get.back();
                                  }, child: const Text("No")),
                                ]
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width*0.50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.cyan.shade100,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text("${chatList[index].msg}"),
                          ),
                        ),
                      );
                    },),
                );
              }
              return CircularProgressIndicator();
           }
          ),
          Card(
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: txtChat,
                    decoration: const InputDecoration(
                      hintText: "Write message",
                    ),
                  ),
                ),
                IconButton(onPressed: () {
                  ChatModel chatModel = ChatModel(
                    dateTime: Timestamp.now(),
                    msg: txtChat.text,
                    senderId: AuthHelper.helper.user!.uid
                  );
                  FireDbHelper.helper.sendMessage(
                      AuthHelper.helper.user!.uid,
                      "${model.uid}",
                      chatModel);
                }, icon: const Icon(Icons.send),color: Colors.blue,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
