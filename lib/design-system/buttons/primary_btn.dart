import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn(
      {Key? key,
      required this.btnTitle,
      required this.btnCallbackFn,
      this.btnColor,
      this.btnRadius,
      this.btnHeight,
      this.btnFontSize})
      : super(key: key);

  final String btnTitle;
  final VoidCallback btnCallbackFn;
  final Color? btnColor;
  final double? btnRadius;
  final double? btnHeight;
  final double? btnFontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius ?? 30),
        ),
        primary: btnColor ?? Theme.of(context).primaryColor,
        minimumSize: Size.fromHeight(btnHeight ?? 60),
      ),
      onPressed: btnCallbackFn,
      child: Text(
        btnTitle,
        style: TextStyle(
          fontSize: btnFontSize ?? 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
