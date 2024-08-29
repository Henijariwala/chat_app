import 'package:get/get.dart';

import '../../../utils/firedb_helper.dart';
import '../../profile/model/profileModel.dart';

class UserController extends GetxController{
  RxList<ProfileModel> profileList = <ProfileModel>[].obs;

  Future<void> getUser() async {
    profileList.value = await FireDbHelper.helper.getAllUser();
  }
}