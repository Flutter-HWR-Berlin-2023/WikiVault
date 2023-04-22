import 'package:flutter/material.dart';

SnackBar showSnackBarSuccess(String title) {
  return SnackBar(
    content: Text(title),
    backgroundColor: Colors.lightGreen,
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar showSnackBarError(String title) {
  return SnackBar(
    content: Text(title),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar showSnackBarInfo(String title) {
  return SnackBar(
    content: Text(title),
    backgroundColor: Colors.grey,
    behavior: SnackBarBehavior.floating,
  );
}
