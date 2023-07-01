import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const TabItem({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Call the onPressed callback when tapped
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
