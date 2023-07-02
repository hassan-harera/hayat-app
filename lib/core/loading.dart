import 'package:flutter/material.dart';

class LoadingIndicator extends ValueNotifier<bool> {
  LoadingIndicator() : super(false);

  void show() {
    value = true;
  }

  void hide() {
    value = false;
  }
}
