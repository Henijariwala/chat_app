import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
                const Text("SignUp",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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

                  String msg = await AuthHelper.helper.signUpEmail(txtEmail.text, txtPassWord.text);
                  if(msg == "Success"){
                    //AuthHelper.helper.checkUser();
                    Get.snackbar("Successful ", "chatApp");
                  }else{
                    Get.snackbar( msg, "chatApp");
                    Get.offAllNamed('signin');
                  }

                }, child: const Text("SignUp")),
                const SizedBox(height: 5,),
                TextButton(onPressed: () {
                  Get.back();
                }, child: const Text("Already have account ?Sign In"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
