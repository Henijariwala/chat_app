import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled5/screen/profile/model/profileModel.dart';
import 'package:untitled5/utils/helper/auth_helper.dart';

import '../../screen/chat/model/chat_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? docId;

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

    //database check as per both uid
   String? id = await checkChatConversation(senderId, receiverId);

   if(id==null) {
     //create new chat
     DocumentReference reference = await fireStore.collection("Chat").add({
       "uids": [senderId, receiverId]
     });
     id = reference.id;
   }

    //add chat
    await fireStore.collection("Chat").doc(id).collection("msg").add({
      "msg": model.msg,
      "date": model.dateTime,
      "sendId": model.senderId,
    });


  }

  Future<String?> checkChatConversation(String senderId , String receiverId) async {
    QuerySnapshot snapshot = await fireStore.collection("Chat").where("uids",isEqualTo:
    [
      senderId,
      receiverId
    ]).get();

    List<DocumentSnapshot> docList = snapshot.docs;

    if(docList.isEmpty){
      QuerySnapshot snapshot = await fireStore.collection("Chat").where("uids",isEqualTo: [
        receiverId,
        senderId,
      ]).get();

      List<DocumentSnapshot> l1 = snapshot.docs;
      if(l1.isEmpty){
        return null;
      }else{
        DocumentSnapshot ds2 = l1[0];
        return ds2.id;
      }
    }
    else{
      DocumentSnapshot sp = docList[0];
      return sp.id;
    }
  }

  Future<void> getChatDoc(String senderId , String receiverId) async {
    docId =await checkChatConversation(senderId, receiverId);
  }
  Stream<QuerySnapshot<Map>> readChat() {
    // List<ChatModel> dataList =[];
    // String? uId = await checkChatConversation(senderId, receiverId);

    //   if(uId != null){
    //     QuerySnapshot sp = await fireStore.collection("Chat").doc(uId).collection("msg").get();
    //     List<DocumentSnapshot> chatList= sp.docs;
    //
    //     for(var x in chatList){
    //       Map m1 = x.data() as Map;
    //       ChatModel model = ChatModel.mapToModel(m1);
    //       dataList.add(model);
    //     }
    //   }
    // }

    Stream<QuerySnapshot<Map>> sp = fireStore.
    collection("Chat").
    doc(docId).
    collection("msg").
    orderBy("date", descending: false).
    snapshots();

    return sp;
  }

  Future<void> deleteChat(String msgId) async {
    await fireStore.
    collection("Chat").
    doc(docId).
    collection("msg").
    doc(msgId).
    delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMyChatUser() {
    return fireStore
        .collection("Chat")
        .where("uids", arrayContains: AuthHelper.helper.user!.uid)
        .snapshots();
  }

  Future<ProfileModel> getUIDUsers(receiverUID) async {
    DocumentSnapshot snapshot = await fireStore.collection("User").doc(receiverUID).get();
    Map m1 = snapshot.data() as Map;
    ProfileModel profileModel =ProfileModel.mapToModel(m1);
    return profileModel;
  }
}
