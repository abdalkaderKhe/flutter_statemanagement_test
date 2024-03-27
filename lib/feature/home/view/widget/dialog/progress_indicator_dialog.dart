import 'package:flutter/material.dart';

final class ProgressIndicatorDialog {
  final BuildContext context;

  ProgressIndicatorDialog({required this.context,});

  void show() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}