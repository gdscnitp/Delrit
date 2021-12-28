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
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/user_img.png',
                            width: 80.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              Text(
                                'Mr. Thangabali',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Tata Indica',
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                '3.5 Stars',
                                style: TextStyle(
                                    color: config.ThemeColors
                                        .mainTextSecondaryColor(1),
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
