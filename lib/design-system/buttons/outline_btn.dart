import 'package:flutter/material.dart';

class OutlineBtn extends StatelessWidget {
  const OutlineBtn(
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
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(btnRadius ?? 30),
        ),
        side: const BorderSide(width: 3.0, color: Colors.white),
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
