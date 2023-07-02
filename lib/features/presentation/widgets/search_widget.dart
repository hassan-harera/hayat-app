import 'dart:core';

import 'package:flutter/material.dart';

class HayatSearchTextFormField extends StatelessWidget {
  TextEditingController? controller;
  double borderRadius = 10;
  TextInputType? keyboardType = TextInputType.text;
  String? hint;
  bool obscure = false;
  bool filledStatus = true;
  Function? suffixFunction;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? labelColor;
  Color? prefixColor;
  Color? suffixColor;
  Color? hintColor;
  Color? backGroundColor;
  Color borderColor;
  double? height;
  double? prefixSize;
  void Function(String)? onChanged;

  HayatSearchTextFormField({super.key,
    required this.borderColor,
    this.controller,
    this.keyboardType,
    this.hint,
    this.obscure = false,
    this.suffixFunction,
    this.prefixIcon,
    this.suffixIcon,
    this.labelColor,
    this.prefixColor,
    this.suffixColor,
    this.hintColor,
    this.backGroundColor,
    this.height,
    this.prefixSize,
    this.onChanged,
    required int borderRadius})

  @override
  Widget build(BuildContext context) =>
      TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'this failed is required';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: prefixColor,
              size: prefixSize,
            ),
            constraints: BoxConstraints(maxHeight: height!),
            hintText: hint!,
            hintStyle: TextStyle(color: hintColor),
            filled: filledStatus,
            fillColor: backGroundColor!,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: borderColor!,
                ),
                borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor))),
      );
}
