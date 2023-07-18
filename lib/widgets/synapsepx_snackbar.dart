import 'package:flutter/material.dart';

class GlobalSnackBar {
  final String message;
  final Color color;
  final bool showActionButton = false;

  const GlobalSnackBar(
    this.color, {
    required this.message,
  });

  static show(
    BuildContext context,
    String message,
    Color color,
    bool showActionButton,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        action: showActionButton
            ? SnackBarAction(
                textColor: Color(0xFFFAF2FB),
                label: 'OK',
                onPressed: () {},
              )
            : null,
      ),
    );
  }
}
