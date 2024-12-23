import 'package:flutter/material.dart';

class DisplayMessage {
  static void errorMessage(BuildContext context, String message) {
    var snackbar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      // backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}