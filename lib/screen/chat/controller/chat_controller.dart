import 'package:get/get.dart';
import 'package:untitled5/utils/firedb_helper.dart';

class ChatController extends GetxController{

  Stream? dataSnap;

  void getChat(){
    dataSnap = FireDbHelper.helper.readChat();
  }
}