import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/auth_helper.dart';

class FireDbHelper{

  static FireDbHelper helper = FireDbHelper._();
  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> setData(ProfileModel profileModel) async {

    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({"name": profileModel.name,
      "mobile":profileModel.mobile,"email":profileModel.email,"bio":profileModel.bio});
  }

  Future<ProfileModel?> signInProfile() async {

     DocumentSnapshot docData= await fireStore.collection("User")
        .doc(AuthHelper.helper.user!.uid)
        .get();

     if(docData.exists){
       Map m1 = docData.data() as Map;
       ProfileModel model = ProfileModel.mapToModel(m1);
       return model;
     }
     else{
       return null;
     }
  }

}