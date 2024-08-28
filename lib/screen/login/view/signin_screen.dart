import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled5/utils/auth_helper.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("ChatApp",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          const Text("SignIn",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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

            String msg = await AuthHelper.helper.signInEmail(txtEmail.text, txtPassWord.text);
            if(msg == "Success"){
              AuthHelper.helper.checkUser();
              Get.offAndToNamed('');
              Get.snackbar("Successful ", "chatApp");
            }else{
              Get.snackbar( msg, "chatApp");
            }

          }, child: const Text("SignIn")),
          InkWell(
            onTap: () async {
              String msg = await AuthHelper.helper.signWithGoogle();
              if(msg == "Success"){
                Get.offAndToNamed('home');
                Get.snackbar("Successful ", "chatApp");
              }else{
                Get.snackbar( msg, "chatApp");
              }
            },
            child: Card(
              child: Image.asset("assets/image/google.png",width: 200,),
            ),
          ),
          TextButton(onPressed: () {
            Get.toNamed('signup');
          }, child: const Text("Create new Account? Sign Up")),
          ElevatedButton(onPressed: () {
            Get.toNamed('home');
          }, child: Text("Next")),
        ],
      ),
    );
  }
}
