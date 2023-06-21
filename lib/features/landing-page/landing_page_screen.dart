import 'package:flutter/material.dart';
import 'package:wecheck/features/landing-page/web_landing_page.dart';
import 'package:wecheck/shared/responsive.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
          mobile: WebLandingPage(
            isMobile: true,
          ),
          desktop: WebLandingPage(
            isMobile: false,
          )),
    );
  }
}
