import 'package:flutter/material.dart';

class CustomNavigator {
  final BuildContext context;
  final Widget screen;

  CustomNavigator({required this.context, required this.screen});

  Future<T?> push<T>() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  Future<T?> pushReplacement<T>() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  Future<T?> pushAndRemoveUntil<T>() {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}
