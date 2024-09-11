import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/firedb_helper.dart';
import '../../../utils/helper/share_helper.dart';
import '../../profile/model/profileModel.dart';

class HomeController extends GetxController{

  Stream<QuerySnapshot<Map>>? chatUsers;
  ProfileModel? model;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;
  RxBool Theme = false.obs;
  Rx<ThemeMode> mode = ThemeMode.light.obs;
  Rx<IconData> icon = Icons.light_mode.obs;

  void getUsers() {
    chatUsers = FireDbHelper.helper.getMyChatUser();
  }

  Future<void> getUIDUsers(receiverId)
  async{
    model = await FireDbHelper.helper.getUIDUsers(receiverId);
  }

  Future<void> setData(bool theme) async {
    ShareHelper.helper.setTheme(theme);
    Theme.value = (await ShareHelper.helper.getTheme())!;
    if (Theme.value == true) {
      icon.value = Icons.light_mode;
      mode.value = ThemeMode.dark;
    } else {
      icon.value = Icons.dark_mode;
      mode.value = ThemeMode.light;
    }
  }

  Future<void> getData() async {
    if (await ShareHelper.helper.getTheme() != null) {
      Theme.value = (await ShareHelper.helper.getTheme())!;
      setData(Theme.value);
    } else {
      Theme.value = false;
      setData(Theme.value);
    }
  }
}