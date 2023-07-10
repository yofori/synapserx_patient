import 'package:flutter/material.dart';

class MyPrescriptionsWidget extends StatefulWidget {
  const MyPrescriptionsWidget({Key? key}) : super(key: key);

  @override
  MyPrescriptionsWidgetState createState() => MyPrescriptionsWidgetState();
}

class MyPrescriptionsWidgetState extends State<MyPrescriptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "This is My Prescription Screen",
              style: TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
