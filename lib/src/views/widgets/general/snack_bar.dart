import 'package:flutter/material.dart';

/// create green success snackbar with info (title)
void showSnackBarSuccess(BuildContext context, String title) => ScaffoldMessenger.of(context).showSnackBar(_snackBarSuccess(title));
SnackBar _snackBarSuccess(String title) {
  return SnackBar(
    content: Text(title),
    backgroundColor: Colors.lightGreen,
    behavior: SnackBarBehavior.floating,
  );
}


/// create red error snackbar with info (title)
void showSnackBarError(BuildContext context, String title) => ScaffoldMessenger.of(context).showSnackBar(_snackBarError(title));
SnackBar _snackBarError(String title) {
  return SnackBar(
    content: Text(title),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
  );
}
