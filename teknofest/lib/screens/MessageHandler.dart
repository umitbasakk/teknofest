import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Result<T> {
  final T? data;
  final String? error;

  Result({this.data, this.error});
}

void ResultHandler(BuildContext context,ContentType contentType,String ErrorTitle,String ErrorContext) {
   final errorHandler = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: ErrorTitle,
        message: ErrorContext,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(errorHandler);
}

