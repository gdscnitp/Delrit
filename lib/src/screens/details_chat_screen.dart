import 'package:flutter/material.dart';

class Chat_ScreenDetail extends StatelessWidget {
  const Chat_ScreenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 5.0),
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_backspace,
                    color: Color.fromRGBO(137, 111, 111, 1),
                    size: 30,
                  ),
                  SizedBox(
                    width: width / 4,
                  ),
                  Text(
                    'Chats',
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              ),
            ),
            Container(
              height: height * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset('assets/images/user_img.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Shailey',
                            style: TextStyle(
                                color: Color.fromRGBO(14, 43, 86, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '1:03 pm',
                            style: TextStyle(
                                color: Color.fromRGBO(144, 123, 123, 1),
                                fontSize: 13.0),
                          )
                        ],
                      ),
                      subtitle: Text(
                        'Will pick you at Gandhi Maidan',
                        style:
                            TextStyle(color: Color.fromRGBO(144, 123, 123, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
