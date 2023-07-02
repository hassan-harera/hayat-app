import 'package:flutter/material.dart';

class LoadingDialogIndicator {
  bool _isShowing = false;

  void show(BuildContext context) {
    if (!_isShowing) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16.0),
                  Text("Loading..."),
                ],
              ),
            ),
          );
        },
      );
      _isShowing = true;
    }
  }

  void hide(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}
