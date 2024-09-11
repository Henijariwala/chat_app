import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled5/utils/app_color.dart';
import 'package:untitled5/utils/helper/auth_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffad87e4),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: 200,
                    color:  const Color(0xffddcef3),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    height: 150,
                    width: MediaQuery.sizeOf(context).width,
                    color: Color(0xffad87e4),
                    child: Image.asset("assets/image/pwalogo.png",height: 100,),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("ChatApp",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                const Text("SignIn",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: txtEmail,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: txtPassWord,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(onPressed: () async {
        
                  String msg = await AuthHelper.helper.signInEmail(txtEmail.text, txtPassWord.text);
                  if(msg == "Success"){
                    AuthHelper.helper.checkUser();
                    Get.offAndToNamed('profile');
                    Get.snackbar("Successful ", "chatApp");
                  }else{
                    Get.snackbar( msg, "chatApp");
                  }
        
                }, child: const Text("SignIn")),
                const SizedBox(height: 5,),
                InkWell(
                  onTap: () async {
                    String msg = await AuthHelper.helper.signWithGoogle();
                    if(msg == "Success"){
                      Get.offAndToNamed('profile');
                      Get.snackbar("Successful ", "chatApp");
                    }else{
                      Get.snackbar( msg, "chatApp");
                    }
                  },
                  child: Image.asset("assets/image/google.png",width: 200,fit: BoxFit.cover,),
                ),
                TextButton(onPressed: () {
                  Get.toNamed('signup');
                }, child: const Text("Create new Account? Sign Up")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
