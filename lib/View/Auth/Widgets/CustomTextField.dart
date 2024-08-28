// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomTextFieled extends StatelessWidget {
  final txt;
  final icon;
  final controller;
  int? maxline = 0;
  String? Function(String?)? validator;
  TextInputType? type = TextInputType.text;
  CustomTextFieled(
      {super.key,
      this.txt,
      this.icon,
      this.controller,
      this.maxline,
      this.type,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      controller: controller,
      maxLines: maxline,
      keyboardType: type,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: txt,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.green.shade400))),
    );
  }
}
