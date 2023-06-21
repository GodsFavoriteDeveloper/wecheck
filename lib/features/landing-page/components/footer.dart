import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({Key? key, required this.isMobile}) : super(key: key);

  bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      padding: EdgeInsets.only(top: 30, bottom: 30, left: 100),
      child: Text(
        "WeCheck. Copyright 2023. All rights reserved",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
