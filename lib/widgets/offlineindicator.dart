import 'package:flutter/material.dart';

class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(3),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            size: 16,
            Icons.cloud_off,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            'You are disconnected from synapseRx',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
