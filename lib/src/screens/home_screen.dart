import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart' as config;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("Handling Here");
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: config.Colors().mainColor(1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/test');
            },
            child: const Text('Map Test'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addride');
            },
            child: const Text('Add Ride'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchrider');
            },
            child: const Text('Search Rider'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
