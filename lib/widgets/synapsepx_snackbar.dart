import 'package:flutter/material.dart';
import 'package:synapserx_patient/main.dart';

class GlobalSnackBar {
  final String message;
  final Color color;
  final bool showActionButton = false;

  const GlobalSnackBar(
    this.color, {
    required this.message,
  });

  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static show(
    String message,
    Color color,
    bool showActionButton,
  ) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        action: showActionButton
            ? SnackBarAction(
                textColor: const Color(0xFFFAF2FB),
                label: 'OK',
                onPressed: () {},
              )
            : null,
      ),
    );
  }
}
