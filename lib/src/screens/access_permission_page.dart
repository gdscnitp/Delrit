import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessPermission extends StatefulWidget {
  const AccessPermission({Key? key}) : super(key: key);

  @override
  _AccessPermissionState createState() => _AccessPermissionState();
}

class _AccessPermissionState extends State<AccessPermission> {
  Future<void> getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.phone,
      Permission.sms,
      Permission.camera,
    ].request();
    if (await Permission.location.request().isGranted) {
      print('location granted');
      Fluttertoast.showToast(msg: "Permission Granted!");
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 8.0),
            child: Image(
              image: AssetImage('assets/images/image8.png'),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Welcome to Ride Share',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Container(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'In order to have a happy-go-lucky experience,\nplease provide us the following permissions:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange[800],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: const ListTile(
                leading: Icon(Icons.fiber_manual_record,
                    size: 10.0, color: Colors.black),
                title: Text(
                  'Location (for finding available car poolers and needy riders)',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: const ListTile(
                leading: Icon(Icons.fiber_manual_record,
                    size: 10.0, color: Colors.black),
                title: Text(
                  ' Phone number (for security purposes)',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: ElevatedButton(
                onPressed: () async {
                  await getPermission();
                  // Navigator.pushNamed(context, '');
                },
                child: const Text(
                  'Give Permissions',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
