import 'package:flutter/material.dart';
import 'package:wecheck/shared/responsive.dart';
import 'web_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
          mobile: WebLoginScreen(
            isMobile: true,
          ),
          desktop: WebLoginScreen(
            isMobile: false,
          )),
    );
  }
}
