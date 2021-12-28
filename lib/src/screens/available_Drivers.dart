import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart' as config;

// import ;

void main() {
  runApp(MaterialApp(
    home: AvailableRiders(),
  ));
}

class AvailableRiders extends StatefulWidget {
  const AvailableRiders({Key? key}) : super(key: key);

  @override
  State<AvailableRiders> createState() => _AvailableRidersState();
}

class _AvailableRidersState extends State<AvailableRiders> {
  String valueChoose = 'Location';
  List listItem = [
    'Location',
    'Time',
    'Gender',
    'Rating',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          title: Text(
            'Available Drivers',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Row(
                children: [
                  Image.asset('assets/images/image_filter.png'),
                  SizedBox(
                    width: 50.0,
                  ),
                  Text(
                    'Filter by',
                    style:
                        // TextStyle(fontSize: 22.0),
                        TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: config.ThemeColors.mainTextColor(1)),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  DropdownButton(
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 0,
                      hint: Text('Select'),
                      value: valueChoose,
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem<String>(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue.toString();
                        });
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: height / 3.0,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/images/user_img.png',
                              height: height / 8.5,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              Text(
                                'Mr. Thangabali',
                                style: TextStyle(
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Tata Indica',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '3.5 Stars',
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'From : Patliputra, Patna',
                            style: TextStyle(
                              color:
                                  config.ThemeColors.mainTextSecondaryColor(1),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
                            'To : Mahendru Ghat, Patna',
                            style: TextStyle(
                              color:
                                  config.ThemeColors.mainTextSecondaryColor(1),
                            ),
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            'On 8th Dec,2021 at 8:30 A.M.',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(height: height * 0.005),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('See Details'),
                          color: config.ThemeColors().mainColor(1),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: height / 3,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              'assets/images/user_img.png',
                              height: height / 8.5,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              Text(
                                'Mr. Thangabali',
                                style: TextStyle(
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Tata Indica',
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '3.5 Stars',
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: height / 35,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'From : Patliputra, Patna',
                            style: TextStyle(
                              color:
                                  config.ThemeColors.mainTextSecondaryColor(1),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
                            'To : Mahendru Ghat, Patna',
                            style: TextStyle(
                              color:
                                  config.ThemeColors.mainTextSecondaryColor(1),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Text(
                            'On 8th Dec,2021 at 8:30 A.M.',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text('See Details'),
                          color: config.ThemeColors().mainColor(1),
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
