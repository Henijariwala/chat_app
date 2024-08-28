import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/auth_helper.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("ChatApp",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          const Text("SignUp",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          TextField(
            controller: txtEmail,
            decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email)
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: txtPassWord,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email)
            ),
          ),
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
          TextButton(onPressed: () {
            Get.back();
          }, child: const Text("Already have account ?Sign In"))
        ],
      ),
    );
  }
}
