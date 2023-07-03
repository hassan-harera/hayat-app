import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingIndicator extends ValueNotifier<bool> {
  LoadingIndicator() : super(false);

  void show() {
    value = true;
  }

  void hide() {
    value = false;
  }
}
