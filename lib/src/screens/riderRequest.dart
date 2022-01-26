
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: Rider(),
    ));

class Rider extends StatefulWidget {
  const Rider({Key? key}) : super(key: key);

  @override
  State<Rider> createState() => _RiderState();
}

class _RiderState extends State<Rider> {
  String valueChoose = 'Location';
  List listItem = [
    'Location',
    'Time',
    'Gender',
    'Rating',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Center(
                      child: Text(
                    "Ride Requests",
                    style:
                        TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/images/filter.png.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      DropdownButton(
                          hint: const Text(
                            'Filter by ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          elevation: 0,
                          icon: const Icon(Icons.arrow_drop_down),
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue.toString();
                            });
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17, right: 17, top: 0),
                  child: Stack(
                    children: [
                      Card(
                        elevation: 7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 70,
                                  width: 70,
                                  child: Image.asset(
                                    'assets/images/user_img.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Ms. Thangabali',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: const [
                                          Icon(CupertinoIcons.location),
                                          Text('Patliputra, Patna'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              //padding: EdgeInsets.only(bottom: 30),

                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: Center(
                                    child: Text(
                                      'See Details',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17, right: 17, top: 5),
                  child: Stack(
                    children: [
                      Card(
                        elevation: 7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 70,
                                  width: 70,
                                  child: Image.asset(
                                    'assets/images/user_img.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Ms. Indumati Ji',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: const [
                                          Icon(CupertinoIcons.location),
                                          Text('Rajeevnagar, Patna'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: Center(
                                    child: Text(
                                      'See Details',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 17, right: 17, top: 5),
                  child: Stack(
                    children: [
                      Card(
                        elevation: 7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  height: 70,
                                  width: 70,
                                  child: Image.asset(
                                    'assets/images/user_img.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Ms. Tuntun Mausi',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: const [
                                          Icon(CupertinoIcons.location),
                                          Text('Kankadbagh, Patna'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              //padding: EdgeInsets.only(bottom: 30),

                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const FractionallySizedBox(
                                  widthFactor: 1.2,
                                  child: Center(
                                    child: Text(
                                      'See Details',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
