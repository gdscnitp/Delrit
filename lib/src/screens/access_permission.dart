import 'package:flutter/material.dart';


class AccessPermission extends StatefulWidget {
  const AccessPermission({ Key? key }) : super(key: key);

  @override
  _AccessPermissionState createState() => _AccessPermissionState();
}

class _AccessPermissionState extends State<AccessPermission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body:Column(crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 8.0),
            child: Image(image: AssetImage('assets/images/image 8.png'),
      ),
          ),
      SizedBox(height: 15,),
      Container(
        child: Text('Welcome to Ride Share',
        style: TextStyle(fontSize: 20.0,
        color: Colors.black,
        ),
        ),
      ),
      SizedBox(height: 10,),
       SizedBox(
        width: double.infinity,
        height: 50,
        child:Container(
          padding:EdgeInsets.all(7.0),
          child: Text('In order to have a happy-go-lucky experience,please provide us the following permissions:',
          style: TextStyle(
            color: Colors.orange[800],
          ),),
        ),
      ),
       SizedBox(
        width: double.infinity,
        height: 40,
        child:
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Text('•  Location(for finding available car poolers and needy riders)',
         style: TextStyle(
        color: Colors.black,
        ), 
        ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 50,
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Text('•  Phone number(for security purposes)',
           style: TextStyle(
        color: Colors.black,
        ),
        ),
        ),
      ),
      SizedBox(height: 20,),
      SizedBox(
        width:double.infinity,
        height: 40,
        child:Container(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child:ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '');
            },
            child: const Text('Give Permissions',
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

