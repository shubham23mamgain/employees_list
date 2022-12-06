import 'package:flutter/material.dart';

circularProgressBar() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(
      top: 12,
    ),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.pinkAccent,
      ),
    ),
  );
}
