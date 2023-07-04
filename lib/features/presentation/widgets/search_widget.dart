import 'dart:core';

import 'package:flutter/material.dart';

class HayatSearchTextFormField extends StatefulWidget {
  TextEditingController? controller;
  TextInputType? keyboardType = TextInputType.text;
  String? hint;
  bool obscure = false;
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
    required int borderRadius
  })


  @override
  State<HayatSearchTextFormField> createState() {
    return _HayatSearchTextFormFieldState();
  }
}

class _HayatSearchTextFormFieldState extends State<HayatSearchTextFormField> {
  double borderRadius = 10;

  bool filledStatus = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'this failed is required';
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              widget.prefixIcon,
              color: widget.prefixColor,
              size: widget.prefixSize,
            ),
            constraints: BoxConstraints(maxHeight: widget.height!),
            hintText: widget.hint!,
            hintStyle: TextStyle(color: widget.hintColor),
            filled: filledStatus,
            fillColor: widget.backGroundColor!,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor!,
                ),
                borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: widget.borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: widget.borderColor))),
      );
  }
}
