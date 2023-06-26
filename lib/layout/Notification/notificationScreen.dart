import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All notification',style: TextStyle(
          fontWeight: FontWeight.bold,

        ),),

      ),
      body: Center(child: Text('notification Screen')),
    );
  }
}