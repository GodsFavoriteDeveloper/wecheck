import 'package:flutter/material.dart';
import 'package:wecheck/design-system/tokens.dart';

class CallToAction extends StatelessWidget {
  const CallToAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Container(
          height: 150,
          child: Image.asset(
            "assets/img/banner.jpeg",
            width: MediaQuery.of(context).size.width,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 150,
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 100),
          height: 150,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Get Started Today",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Learn More",
                  style: TextStyle(color: DesignSystem.GEMSBlue),
                ))
          ]),
        ),
      ]),
    );
  }
}
