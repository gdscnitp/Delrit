import 'components/body.dart';
import 'package:flutter/material.dart';

class AvailableDrivers extends StatefulWidget {
  const AvailableDrivers({Key? key}) : super(key: key);

  @override
  State<AvailableDrivers> createState() => _AvailableDriversState();
}

class _AvailableDriversState extends State<AvailableDrivers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: const Text(
          'Available Drivers',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Body(context),
    );
  }
}
