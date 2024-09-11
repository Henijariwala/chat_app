import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/home/controller/home_controller.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/app_color.dart';
import 'package:untitled5/utils/helper/auth_helper.dart';
import 'package:untitled5/utils/helper/firedb_helper.dart';
import 'package:untitled5/utils/service/notification_service.dart';

import '../../../utils/helper/share_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        title: const Text("ChatApp"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code_scanner)),
          // IconButton(
          //   onPressed: () {
          //     NotificationService.notificationService.showSimpleNotification("");
          //   },
          //   icon: const Icon(Icons.notifications),
          // ),
          // IconButton(
          //   onPressed: () {
          //     NotificationService.notificationService.showScheduleNotification();
          //   },
          //   icon: const Icon(Icons.schedule),
          // ),
          // IconButton(
          //   onPressed: () {
          //     NotificationService.notificationService.showMediaStyleNotification();
          //   },
          //   icon: const Icon(Icons.music_note),
          // ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                color: Color(0xff7b3fd3),
            ),
            child: const Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SearchBar(
                    leading: Icon(Icons.search_rounded),
                    hintText: "Search",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          StreamBuilder(stream: controller.chatUsers,
            builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            else if(snapshot.hasData){
              controller.userList.clear();
              QuerySnapshot? qs =snapshot.data;
              List<QueryDocumentSnapshot> qsList =qs!.docs;

              for(var x in qsList ){
                Map m1 =x.data() as Map;
                List uidList= m1['uids'];
                String receiverID ="";
                if(uidList[0]==AuthHelper.helper.user!.uid){
                 receiverID= uidList[1];
                }else{
                  receiverID=uidList[0];
                }
                //getUserData receiver USer ID
                controller.getUIDUsers(receiverID).then((value) {
                  controller.userList.add(controller.model!);
                },);

              }

              return Obx(
                    () => Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () async {
                            await FireDbHelper.helper.getChatDoc(AuthHelper.helper.user!.uid, controller.userList[index].uid!);
                            Get.toNamed('chat',arguments: controller.userList[index]);
                          },
                          leading: CircleAvatar(
                            child: Text("${controller.userList[index].name![0]}"),
                          ),
                          title:  Text("${controller.userList[index].name}"),
                          subtitle: Text("${controller.userList[index].mobile}"),
                        ),
                      );
                                        },
                                        itemCount: controller.userList.length,
                                      ),
                    ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Card(
              shadowColor: purple,
              child: ListTile(
                onTap: () async {
                  Get.toNamed('profile');
                },
                title: const Text("Profile"),
                leading: const Icon(Icons.person,),
              ),
            ),
            Obx(
              () => Card(
                shadowColor: purple,
                child: ListTile(
                  onTap: () async {
                    bool theme = controller.Theme.value;
                    theme = !theme;
                    controller.setData(theme);
                  },
                  title: const Text("Theme"),
                  leading: Icon(controller.icon.value,),
                ),
              ),
            ),
            const Spacer(),
            Card(
              shadowColor: purple,
              child: ListTile(
                onTap: () async {
                  await AuthHelper.helper.signOut();
                  Get.offAllNamed('signin');
                },
                title: const Text("LogOut"),
                leading: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed('user');
      },child: const Icon(Icons.person),),
    );
  }
}
