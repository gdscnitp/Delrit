import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_services.dart';
import '../src/screens/chat_screen/chat_screen.dart';

class ChatScreenModel extends BaseModel {
  String message = '';
  late String meUid;
  late String peerUid;
  late String chatRoomId;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File? pickedImage;

  final ApiService apiService = ApiService();

  void init(String peerId) {
    meUid = FirebaseAuth.instance.currentUser?.uid ?? "";
    peerUid = peerId;
    createChatRoom();
  }

  // getChatUsers() {
  //   final User meUser = auth.currentUser!;
  //   meUid = meUser.uid.toString();
  //   final User peerUser;

  //   //id taken for testing
  //   peerUid = 'I8humTJNWDNAnDVN82j6iiTcqvE2';
  // }

  createChatRoom() {
    if (meUid.hashCode <= peerUid.hashCode) {
      chatRoomId = meUid + '-' + peerUid;
    } else {
      chatRoomId = peerUid + '-' + meUid;
    }

    // chatRoomId = "3rhCMkQqCjf7yZO9CyYvxnwP4uh1-I8humTJNWDNAnDVN82j6iiTcqvE2";
  }

  createChatRoomInDB() async {
    await db.collection('chats').doc(chatRoomId).set({
      'chatRoomId': chatRoomId,
      'users': [meUid, peerUid]
    });
  }

  saveChatMessage() async {
    if (message != '') {
      Map<String, dynamic> chatData = {
        "message": message,
        "sendBy": meUid,
        "createdAt": DateTime.now()
      };
      db.collection('chats').doc(chatRoomId).collection("room").add(chatData);

      var body = {
        "receiverUid": peerUid,
        "senderUid": meUid,
        "message": message,
        "image": pickedImage,
      };

      final ApiResponse response = await apiService.sendChatNotification(body);
      print(response.data);
    }
  }

  Future pickImage(context) async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedImage = File(value!.path);
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('media')
          .child(DateTime.now().microsecondsSinceEpoch.toString() + '.jpg');
      UploadTask task = reference.putFile(pickedImage!);

      task.whenComplete(() {
        reference.getDownloadURL().then((value) {
          message = value;
        });
      });
    });
  }
}
