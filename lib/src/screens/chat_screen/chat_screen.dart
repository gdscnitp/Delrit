import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/riderRequest.dart';
import 'package:ride_sharing/src/widgets/app_bar.dart';
import 'package:ride_sharing/view/chat_viewmodel.dart';
import 'package:ride_sharing/config/app_config.dart' as config;


import 'chatscreen_components/chat_screen_body.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.peer}) : super(key: key);
  UserProfileModel peer;

  String peerName = 'Ms. Chuimui';
  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return BaseView<ChatScreenModel>(
      onModelReady: (model) => model.init(peer.id!),
      builder: (ctx, model, child) => Scaffold(
        appBar: appBar(peer.name ?? "Peer", context),
        body: SafeArea(
          child: Column(
            children: [
              const Divider(
                height: 2.0,
                thickness: 13,
                color: Colors.blue,
              ),
              const SizedBox(height: 10.0),
              ChatScreenBody(model),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(83, 67, 67, 0.41),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2.0, 2.0, 0, 4.0),
                          child: TextFormField(
                            onFieldSubmitted:(_)=>{
                               model.saveChatMessage(),
                          model.message = '',
                          clearText(),
                            },
                            controller: fieldText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type Something',
                              hintStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 40,
                                  color:
                                      const Color.fromRGBO(83, 67, 67, 0.41)),
                            ),
                            onChanged: (value) {
                              model.message = value;
                            },
                          ),
                        ),
                      ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 35,
                          width: 35,
                          child: GestureDetector(
                          onTap: () async {
                            await model.pickImage(context);
                        
                          },
                          child: Image.asset('assets/images/album.png'),
                      ),
                        ),
                    
                      IconButton(
                        onPressed: () {
                          model.saveChatMessage();
                          model.message = '';
                          clearText();
                        },
                        
                        icon: Icon(
                          Icons.send,
                          color: config.ThemeColors().mainColor(1),
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
