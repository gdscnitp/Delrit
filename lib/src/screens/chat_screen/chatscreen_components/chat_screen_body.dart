import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/chatscreen_model.dart';

class ChatScreenBody extends StatefulWidget {
  const ChatScreenBody({Key? key}) : super(key: key);

  @override
  _ChatScreenBodyState createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<ChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ChatScreenModel>(
        builder: (ctx, model, child) => StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(model.chatRoomId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                var chatDocument = snapshot.data;

                return Container(
                    height: 500,
                    child: ListView.builder(
                        itemCount: chatDocument!["chats"].length,
                        itemBuilder: (document, index) {
                          return chatDocument["chats"][index]["sendBy"]
                                      .toString() ==
                                  model.meUid
                              ? getSenderView(
                                  ChatBubbleClipper1(
                                      type: BubbleType.sendBubble),
                                  context,
                                  chatDocument["chats"][index]["message"]
                                      .toString())
                              : getReceiverView(
                                  ChatBubbleClipper1(
                                      type: BubbleType.receiverBubble),
                                  context,
                                  chatDocument["chats"][index]["message"]
                                      .toString());
                        }));
              },
            ));
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
