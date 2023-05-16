import 'package:flutter/material.dart';

actionDialogue({context, child}) {
  return showDialog(
      barrierColor: Colors.grey.withOpacity(0.5),
      context: context,
      builder: (_) {
        return AlertDialog(backgroundColor: Colors.white, content: child);
      });
}
