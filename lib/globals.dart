import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'Global');
final GlobalKey<NavigatorState> homeNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'Home');
final GlobalKey<NavigatorState> settingsNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'Settings');



class CustomException implements Exception {
  final String message;
  final int? errorCode;
  final String? functionName;

  CustomException({required this.message, this.errorCode, this.functionName});

  @override
  String toString() {
    return 'CustomException: $message (Error Code: $errorCode)';
  }
}
