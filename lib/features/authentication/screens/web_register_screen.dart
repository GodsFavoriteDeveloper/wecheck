import 'package:flutter/material.dart';
import 'package:wecheck/features/authentication/components/register_form.dart';

class WebRegisterScreen extends StatelessWidget {
  WebRegisterScreen({Key? key, required this.isMobile}) : super(key: key);
  bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Expanded(child: RegisterForm()),
        isMobile
            ? SizedBox()
            : Expanded(
                child: Image.asset(
                "assets/img/banner.jpeg",
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
              )),
      ]),
    );
  }
}
