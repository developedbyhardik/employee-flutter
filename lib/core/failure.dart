import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Failure implements Exception {
  final String message;
  final int? code;
  final Exception? exception;
  final StackTrace stackTrace;

  Failure({
    required this.message,
    required this.stackTrace,
    this.code,
    this.exception,
  });

  @override
  String toString() {
    return 'Failure(message: $message, code: $code, exception: $exception,  stackTrace: $stackTrace)';
  }
}

void showErrorToast({
  required BuildContext context,
  required String message,
  required int duration,
}) {
  toastification.show(
      context: context,
      description: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontFamily: "CircularStd-Book",
              color: Palette.black,
            ),
      ),
      alignment: Alignment.bottomCenter,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: Duration(seconds: duration));
}
