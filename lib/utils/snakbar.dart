import 'package:flutter/material.dart';

dynamic showSnackbar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}
