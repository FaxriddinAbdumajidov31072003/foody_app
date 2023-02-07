import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:foody_app/controller/local_store/local.dart';
import 'package:foody_app/model/chats_model.dart';
import 'package:foody_app/model/message_model.dart';

import '../model/user_model.dart';

class ChatController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<UserModel> users = [];
  List<ChatsModel> chats = [];
  List<MessageModel> messages = [];
  List listOfDocIdChats = [];
  List listOfDocIdUser = [];
  String userId = "";
  bool addUser = false;
  bool isLoading = true;
  String editMessId = "";
  String oldText = "";
  DateTime? editTime;

  changeEditText(
      {required String messId,
      required String oldText,
      required DateTime time}) {
    editMessId = messId;
    editTime = time;
    this.oldText = oldText;
  }

  changeAddUser() {
    addUser = !addUser;
    notifyListeners();
  }

  getUserList() async {
    var res = await firestore.collection("users").get();
    String? userId = await LocalStore.getDocId();
    users.clear();
    listOfDocIdUser.clear();

    for (var element in res.docs) {
      if (userId != element.id) {
        users.add(UserModel.fromJson(element.data()));
        listOfDocIdUser.add(element.id);
      }
    }
    notifyListeners();
  }

  getChatList() async {
    var res = await firestore
        .collection("chats")
        .where("ids", arrayContainsAny: [await LocalStore.getDocId()]).get();
    for (var element in res.docs){
      int ownerIndex =
      (element.data()["ids"] as List).indexOf(await LocalStore.getDocId());

       firestore.collection("chats").doc(element.id).update({
         "ids": [
           (element.data()["ids"] as List)[0],
           (element.data()["ids"] as List)[1]
         ],
         "onlines": ownerIndex == 0
             ? [true, (element.data()["onlines"] as List)[1]]
             : [(element.data()["onlines"] as List)[0],true]
       });
    }
    firestore
        .collection("chats")
        .where("ids", arrayContainsAny: [await LocalStore.getDocId()])
        .snapshots()
    .listen((res) async{
      listOfDocIdChats.clear();
      chats.clear();
      for(var element in res.docs){
        int ownerIndex =  (element.data()["ids"] as List)
            .indexOf(await LocalStore.getDocId());
        var reUser = await firestore
        .collection("users")
        .doc((element.data()["ids"] as List)[ownerIndex == 0?1:0])
        .get();
        chats.add(ChatsModel.fromJson(
            data: element.data(),
            resender: reUser.data(),
            isOnline: (element.data()["onlines"] ?[ownerIndex == 0?1:0]) ??
        false));
      listOfDocIdChats.add(element.id);
      }
      notifyListeners();
    });
  }

  getMessages(String docId) async {
    isLoading = true;
    notifyListeners();
    userId = await LocalStore.getDocId() ?? "";
    firestore
    .collection("chats")
    .doc(docId)
    .collection("messages")
    .snapshots()
    .listen((res) {
      messages.clear();
      for (var element in res.docs) {

        messages.add(
          MessageModel.fromJson(
            data: element.data(),
            messId: element.id,
          ),
        );
      }
      messages.sort((a, b) => b.time.compareTo(a.time));
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }

  createChat(int index, ValueChanged<String> onSuccess) async {
    var res = await firestore.collection("chats").add({
      "ids": [listOfDocIdUser[index], await LocalStore.getDocId()],
      "onlines": [false, true]
    });
    onSuccess(res.id);
  }

  sendMessage(String title, String docId,String meesId) async {
    firestore
        .collection("chats")
        .doc(docId)
        .collection("messages")
        .add(MessageModel(
      title: title,
      time: DateTime.now(),
      ownerId: await LocalStore.getDocId() ?? "",
      messId: '',

    ).toJson());
  }

  deleteMessage({required String chatDocId, required String messDocId}) {
    firestore
        .collection("chats")
        .doc(chatDocId)
        .collection("messages")
        .doc(messDocId)
        .delete();
  }

  editMessage(
      {required String chatDocId,
        required String messDocId,
        required String newMessage,
        required DateTime time}) {
    if (newMessage != oldText) {
      firestore
          .collection("chats")
          .doc(chatDocId)
          .collection("messages")
          .doc(messDocId)
          .update(MessageModel(
        title: newMessage,
        time: time,
        ownerId: userId,
        messId: "",
      ).toJson());
    }
    editTime = null;
  }
}
