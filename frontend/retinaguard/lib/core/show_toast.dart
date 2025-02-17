import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({required message, bool isError = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: !isError ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 18.0,
  );
}
