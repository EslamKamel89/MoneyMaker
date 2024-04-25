import 'package:flutter/material.dart';
import 'package:trading/core/text_styles/text_style.dart';

customSnackBar({
  required BuildContext context,
  required String title,
  required Color backgroundColor,
  int? durationSeconds,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Txt.bodyMeduim(
        title,
        color: Colors.white,
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: durationSeconds ?? 2),
    ),
  );
}
