import 'package:flutter/material.dart';

class AlertMSGWidget extends StatelessWidget {
  const AlertMSGWidget(
      {super.key,
      required this.title,
      required this.actionButtonText,
      required this.subtitle,
      required this.imageLocation,
      required this.action,
      required this.showActionButton});
  final String title;
  final String subtitle;
  final String imageLocation;
  final bool showActionButton;
  final String? actionButtonText;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(imageLocation),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        showActionButton
            ? ElevatedButton(onPressed: action, child: const Text('Retry'))
            : Container(),
      ],
    );
  }
}
