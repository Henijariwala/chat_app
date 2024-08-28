import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/firedb_helper.dart';

class ProfileController extends GetxController{

  ProfileModel? profileModel;

  Future<void> getSignInProfile() async {
    profileModel= await FireDbHelper.helper.signInProfile();
  }
}