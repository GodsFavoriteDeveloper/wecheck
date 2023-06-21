import 'package:flutter/material.dart';

class HalfScreenLogo extends StatelessWidget {
  const HalfScreenLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              'https://img.freepik.com/premium-photo/young-black-friends-smiling-camera-african-people-with-different-skin-colors-taking-selfie-with-smartphone_442523-170.jpg?w=2000p]]]',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  'assets/img/logo.jpg',
                  width: 160,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
