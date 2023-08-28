import 'package:flutter/material.dart';

class MyAppLifecycleObserver extends WidgetsBindingObserver {
  final Function() onCloseCallback;

  MyAppLifecycleObserver({required this.onCloseCallback});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onCloseCallback(); // Call the function when app is paused (closed)
    }
  }
}
