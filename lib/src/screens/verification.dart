import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: PhoneScreen(),
    ));

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text(
                        'Enter your phone number for verification.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'This number will be used for ride sharing related communication.You will recieve an SMS with OTP for\n verification.',
                        style: TextStyle(fontFamily: 'Roboto'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: TextField(
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    prefixIcon: Icon(Icons.flag_outlined),
                                    suffixIcon:
                                        Icon(Icons.arrow_drop_down_outlined),
                                  ),
                                  keyboardType: TextInputType.number,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 6,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Your Number',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 240),
                        width: 280,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
