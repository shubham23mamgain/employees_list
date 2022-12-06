import 'package:flutter/material.dart';
import 'package:zylu_test/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  const LoadingDialog({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgressBar(),
          const SizedBox(height: 10),
          Text("${message!} Please Wait ..."),
        ],
      ),
    );
  }
}
