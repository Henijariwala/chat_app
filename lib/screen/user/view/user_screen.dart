import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/user/controller/user_controller.dart';
import 'package:untitled5/utils/app_color.dart';
import 'package:untitled5/utils/helper/auth_helper.dart';
import 'package:untitled5/utils/helper/firedb_helper.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController controller = Get.put(UserController());
  @override
  void initState() {
    controller.getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        title: const Text("User"),
      ),
      body: Obx(
       () =>  ListView.builder(
          itemCount: controller.profileList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: ()async {
               await  FireDbHelper.helper.getChatDoc(
                    AuthHelper.helper.user!.uid,
                    controller.profileList[index].uid!);
                Get.toNamed('chat',arguments: controller.profileList[index]);
              },
              child: Card(
                shadowColor: purple,
                child: ListTile(
                  title: Text("${controller.profileList[index].name}"),
                  leading: CircleAvatar(
                    child: Text(controller.profileList[index].name![0]),
                  ),
                  subtitle: Text("${controller.profileList[index].mobile}"),
                ),
              ),
            );
          },),
      ),
    );
  }
}