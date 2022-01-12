import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:ride_sharing/view/chat_viewmodel.dart';

class ChatScreenBody extends StatefulWidget {
  ChatScreenModel model;
  ChatScreenBody(this.model, {Key? key}) : super(key: key);

  @override
  _ChatScreenBodyState createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.model.chatRoomId)
            .collection("room")
            .orderBy("createdAt")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            widget.model.createChatRoomInDB();
            return const Text("Start a conversation!");
          }
          var chatDocument = snapshot.data!.docs.reversed.toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              itemCount: chatDocument.length,
              itemBuilder: (document, index) {
                return chatDocument[index]["sendBy"].toString() ==
                        widget.model.meUid
                    ? getSenderView(
                        ChatBubbleClipper5(type: BubbleType.sendBubble),
                        context,
                        chatDocument[index]["message"].toString(),
                      )
                    : getReceiverView(
                        ChatBubbleClipper5(type: BubbleType.receiverBubble),
                        context,
                        chatDocument[index]["message"].toString(),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}

getSenderView(CustomClipper clipper, BuildContext context, String child) =>
    ChatBubble(
      clipper: clipper,
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: 20),
      backGroundColor: Colors.blue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          child,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

getReceiverView(CustomClipper clipper, BuildContext context, String child) =>
    ChatBubble(
      clipper: clipper,
      backGroundColor: Color(0xffE7E7ED),
      margin: EdgeInsets.only(top: 20),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          child,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
