import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/home/controller/home_controller.dart';
import 'package:untitled5/utils/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatApp"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code_scanner)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    child: Container(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width,
                        child:  const ListTile(
                          title: Text("Mansi"),
                          leading: CircleAvatar(),
                          trailing: Text("11:00"),
                          subtitle: Text("Hello"),
                        )
                    ),
                  ),
                ],
              );
            },),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            ListTile(
              onTap: () async {
                Get.toNamed('profile');
              },
              title: const Text("Profile"),
              leading: const Icon(Icons.person),
            ),
            const Spacer(),
            ListTile(
              onTap: () async {
                await AuthHelper.helper.signOut();
                Get.offAllNamed('signin');
              },
              title: const Text("LogOut"),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed('user');
      },child: Icon(Icons.person),),
    );
  }
}
