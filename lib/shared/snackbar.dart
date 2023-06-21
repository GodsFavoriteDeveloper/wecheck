import 'package:flutter/material.dart';

presentSnackBar({required String message, required BuildContext context}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
