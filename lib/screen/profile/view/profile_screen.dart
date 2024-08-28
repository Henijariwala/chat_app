import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/screen/profile/controller/profile_controller.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/firedb_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    getData();
    super.initState();
  }
  Future<void> getData() async {
    await controller.getSignInProfile();
    if(controller.profileModel != null){
      txtName.text=controller.profileModel!.name!;
      txtEmail.text=controller.profileModel!.email!;
      txtBio.text=controller.profileModel!.bio!;
      txtMobile.text=controller.profileModel!.mobile!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Name"),
                prefixIcon: Icon(Icons.person)
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: txtBio,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Bio"),
                prefixIcon: Icon(Icons.account_box_outlined)
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: txtEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Email"),
                prefixIcon: Icon(Icons.email)
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: txtMobile,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Mobile"),
                prefixIcon: Icon(Icons.phone)
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton.icon(onPressed: () {
              ProfileModel model = ProfileModel(
                name: txtName.text,
                mobile: txtMobile.text,
                email: txtEmail.text,
                bio: txtBio.text,
              );
              FireDbHelper.helper.setData(model);
              Get.toNamed('home');
            },
              label: const Text("Submit"),
              icon: Icon(Icons.save),)
          ],
        ),
      ),
    );
  }
}
