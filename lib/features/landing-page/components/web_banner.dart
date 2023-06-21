import 'package:flutter/material.dart';

class WebBanner extends StatelessWidget {
  WebBanner({Key? key, required this.isMobile}) : super(key: key);

  bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Image.asset(
          "assets/img/banner.jpg",
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
