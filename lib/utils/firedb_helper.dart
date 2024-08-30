import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/auth_helper.dart';

import '../screen/chat/model/chat_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<void> setData(ProfileModel profileModel) async {
    await fireStore.collection("User").doc(AuthHelper.helper.user!.uid).set({
      "name": profileModel.name,
      "mobile": profileModel.mobile,
      "email": profileModel.email,
      "bio": profileModel.bio,
      "uid": AuthHelper.helper.user!.uid
    });
  }

  Future<ProfileModel?> signInProfile() async {
    DocumentSnapshot docData = await fireStore
        .collection("User")
        .doc(AuthHelper.helper.user!.uid)
        .get();

    if (docData.exists) {
      Map m1 = docData.data() as Map;
      ProfileModel model = ProfileModel.mapToModel(m1);
      return model;
    } else {
      return null;
    }
  }

  Future<List<ProfileModel>> getAllUser() async {
    List<ProfileModel> profileList = [];
    QuerySnapshot snapshot = await fireStore
        .collection("User")
        .where("uid", isNotEqualTo: AuthHelper.helper.user!.uid)
        .get();
    List<QueryDocumentSnapshot> docList = snapshot.docs;

    for (var x in docList) {
      Map m1 = x.data() as Map;
      String docId = x.id;
      ProfileModel model = ProfileModel.mapToModel(m1);
      model.uid = docId;
      profileList.add(model);
    }
    return profileList;
  }

  Future<void> sendMessage(String senderId , String receiverId , ChatModel model) async {
    //create new chat

    DocumentReference reference =await fireStore.collection("Chat").add({
      "uids":[senderId,receiverId]
    });

    //add chat
    await fireStore.collection("Chat").doc(reference.id).collection("msg").add({
      "msg": model.msg,
      "date": model.dateTime,
      "sendId": model.senderId,
    });


  }

  Future<void> checkChatConversation(String senderId , String receiverId) async {
    QuerySnapshot snapshot = await fireStore.collection("Chat").where("uids",arrayContainsAny: [
      senderId,
      receiverId
    ]).get();

    List<DocumentSnapshot> l1 = snapshot.docs;

    if(l1.isEmpty){
      QuerySnapshot snapshot = await fireStore.collection("Chat").where("uids",arrayContainsAny: [
        receiverId,
        senderId
      ]).get();

      List<DocumentSnapshot> l2 = snapshot.docs;
      if(l2.isEmpty){
        print("Not any conversation =======");
      }else{
        print("Yes Conversation ====${l1.length}");
      }
    }else{
      print("Yes =======${l1.length}");
    }
  }
}
