import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/auth_helper.dart';

class FireDbHelper{

  static FireDbHelper helper = FireDbHelper._();
  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> setData(ProfileModel profileModel) async {

    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": profileModel.name,
      "mobile":profileModel.mobile,
      "email":profileModel.email,
      "bio":profileModel.bio,
      "uid":AuthHelper.helper.user!.uid
    });
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

  Future<List<ProfileModel>> getAllUser() async {
    List<ProfileModel> profileList =[];
     QuerySnapshot snapshot =await fireStore.collection("User").where("uid",isNotEqualTo: AuthHelper.helper.user!.uid).get();
     List<QueryDocumentSnapshot> docList =snapshot.docs;


     for(var x in docList){
       Map m1 = x.data() as Map;
       String docId = x.id;
       ProfileModel model = ProfileModel.mapToModel(m1);
       model.uid= docId;
       profileList.add(model);
     }
     return profileList;
  }

}