import 'package:flutter/material.dart';
import 'package:wecheck/features/landing-page/components/call_to_action.dart';
import 'package:wecheck/features/landing-page/components/explainers.dart';
import 'package:wecheck/features/landing-page/components/web_banner.dart';
import 'package:wecheck/features/landing-page/components/web_navbar.dart';

import 'components/footer.dart';

class WebLandingPage extends StatelessWidget {
  WebLandingPage({Key? key, required this.isMobile}) : super(key: key);
  bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          isMobile ? MobileNavBar() : WebNavBar(),
          WebBanner(
            isMobile: isMobile,
          ),
          isMobile ? ExplainersMobile() : Explainers(),
          // isMobile ? SizedBox() : CallToAction(),
          Footer(
            isMobile: true,
          )
        ]),
      ),
    );
  }
}
