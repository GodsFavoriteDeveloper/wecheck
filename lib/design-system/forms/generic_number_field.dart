import 'package:flutter/material.dart';

class GenericNumberField extends StatelessWidget {
  GenericNumberField(
      {Key? key,
      required this.controller,
      required this.title,
      this.isreadOnly})
      : super(key: key);

  TextEditingController controller;
  String? title;
  bool? isreadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        readOnly: isreadOnly ?? false,
        validator: (val) {
          if (val!.isEmpty) {
            return '$title cannot be empty';
          }

          if (double.tryParse(val) == null) {
            return 'Please enter a valid $title';
          }

          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
            // borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: title,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
