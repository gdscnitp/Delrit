import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_model.dart';

class ChatScreenModel extends BaseModel {
  String message = '';
  String meUid = "3rhCMkQqCjf7yZO9CyYvxnwP4uh1";
  String peerUid = "";
  String chatRoomId =
      "3rhCMkQqCjf7yZO9CyYvxnwP4uh1-I8humTJNWDNAnDVN82j6iiTcqvE2";

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  getChatUsers() {
    final User meUser = auth.currentUser!;
    meUid = meUser.uid.toString();
    final User peerUser;

    //id taken for testing
    peerUid = 'I8humTJNWDNAnDVN82j6iiTcqvE2';
  }

  createChatRoom() {
    if (meUid.hashCode <= peerUid.hashCode) {
      chatRoomId = meUid + '-' + peerUid;
    } else {
      chatRoomId = peerUid + '-' + meUid;
    }
  }

  saveChatMessage() async {
    if (message != '') {
      Map<String, dynamic> chatData = {
        "message": message,
        "sendBy": meUid,
        "createdAt": DateTime.now()
      };
      db.collection('chats').doc(chatRoomId).set({
        'id': chatRoomId,
        "chats": FieldValue.arrayUnion([chatData])
      }, SetOptions(merge: true));
    }
  }
}
