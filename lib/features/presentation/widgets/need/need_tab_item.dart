import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;

  const TabItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
