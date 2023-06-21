import 'package:flutter/material.dart';

void presentGEMSSnackBar(BuildContext context, String text,
    {Color color = Colors.black}) {
  var snackBar = SnackBar(
    backgroundColor: color,
    content: Text(text),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void navigateViaMaterialRoute(context, Widget page, {replace = false}) {
  if (replace) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
