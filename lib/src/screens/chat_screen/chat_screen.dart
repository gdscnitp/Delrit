import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/widgets/app_bar.dart';
import 'package:ride_sharing/view/chat_viewmodel.dart';

import 'chatscreen_components/chat_screen_body.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  String peerName = 'Ms. Chuimui';
  @override
  Widget build(BuildContext context) {
    return BaseView<ChatScreenModel>(
        builder: (ctx, model, child) => Scaffold(
              appBar: appBar(peerName, context),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ChatScreenBody(),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            onChanged: (value) {
                              model.message = value;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            model.saveChatMessage();
                            model.message = '';
                          },
                          icon: Icon(Icons.send),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
