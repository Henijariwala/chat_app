import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/chat/controller/chat_controller.dart';
import 'package:untitled5/screen/chat/model/chat_model.dart';
import 'package:untitled5/screen/home/controller/home_controller.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/app_color.dart';
import 'package:untitled5/utils/helper/auth_helper.dart';
import 'package:untitled5/utils/helper/firedb_helper.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController txtChat = TextEditingController();
  ProfileModel model=Get.arguments;
  ChatController controller = Get.put(ChatController());
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    controller.getChat();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        title: Text("${model.name}",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        leading: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            child: Text(model.name![0]),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_outlined,size: 30,)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
        ],
      ),
      body: Stack(
        children: [
          homeController.Theme.value == false
              ?Image.asset("assets/image/chat_bg.jpg",
            height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover)
              :Image.asset("assets/image/chat_dark.jpg",
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover),
          Column(
            children: [
              StreamBuilder(
                stream: controller.dataSnap,
                builder:(context, snapshot) {
                  if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }else if(snapshot.hasData){
                    List<ChatModel> chatList = [];
                    QuerySnapshot? snap = snapshot.data;
                    List<Map<String,int>> dateList =[];
                    List<int> indexList =[];

                    for(var x in  snap!.docs){
                      Map m1 = x.data() as Map;
                      ChatModel c1 = ChatModel.mapToModel(m1);
                      c1.docId = x.id;
                      chatList.add(c1);
                      if(dateList.isEmpty)
                        {
                          dateList.add({chatList[0].dateTime!.toDate().toString():0});
                          indexList.add(0);
                        }
                      if(dateList.last.keys.last.split(" ")[0]!=c1.dateTime!.toDate().toString().split(" ")[0])
                        {
                          print("===================== ${dateList.last.keys.last.split(" ")[0]} == ${c1.dateTime!.toDate().toString().split(" ")[0]}");
                          dateList.add({c1.dateTime!.toDate().toString():chatList.length-1});
                          indexList.add(chatList.length-1);
                        }
                    }

                    print("===================== $dateList");
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return indexList.contains(index)?Center(
                            child: Container(
                              height: 50,
                              width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color:  const Color(0xff7bb5d5),
                                  borderRadius: BorderRadius.circular(10)
                                ), child: Text("${chatList[index].dateTime!.toDate()}",
                              style: const TextStyle(color: Colors.black, fontSize: 14),)),
                          ):const Text("");
                        },
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              // Container(
                              //   height: 50,
                              //   width: 100,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: const Color(0xff7bb5d5)
                              //   ),
                              //   child: Text("${chatList[index].dateTime!.toDate().day}${chatList[index].dateTime!.toDate().month}",style: const TextStyle(
                              //     fontSize: 15,
                              //     color: Colors.black
                              //   ),),
                              // ),
                              Container(
                                height: 50,
                                margin: const EdgeInsets.all(5),
                                alignment: chatList[index].senderId != AuthHelper.helper.user!.uid
                                    ?Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: InkWell(
                                  onLongPress: () {

                                    if(chatList[index].senderId == AuthHelper.helper.user!.uid){
                                      Get.defaultDialog(
                                        title: "You want to delete msg",
                                        content: const Text("Are you sure..!!"),
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
                                        color: chatList[index].senderId != AuthHelper.helper.user!.uid
                                            ? const Color(0xffb696e7)
                                            : const Color(0xffdecff4),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text("${chatList[index].msg}",style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                                          const Spacer(),
                                          Text("${chatList[index].dateTime!.toDate().hour}:${chatList[index].dateTime!.toDate().minute}",style: const TextStyle(
                                            color: Colors.black,
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },),
                    );
                  }
                  return const CircularProgressIndicator();
               }
              ),
              Card(
                surfaceTintColor: purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: txtChat,
                          decoration: const InputDecoration(
                            hintText: "Write message",
                            focusColor: purple,
                          ),
                          cursorColor: purple,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton.filled(
                          onPressed: () {
                          ChatModel chatModel = ChatModel(
                            dateTime: Timestamp.now(),
                            msg: txtChat.text,
                            senderId: AuthHelper.helper.user!.uid
                          );
                          FireDbHelper.helper.sendMessage(
                              AuthHelper.helper.user!.uid,
                              "${model.uid}",
                              chatModel);
                        }, icon: const Icon(Icons.send),style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(purple),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),iconSize: WidgetStatePropertyAll(30)
                        ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
