import 'package:flutter/material.dart';

AppBar authAppBar({
  required String title,
  required BuildContext context,
  bool automaticallyImplyLeading = true,
}) {
  return AppBar(
    // title: Txt.headlineMeduim(title),
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: automaticallyImplyLeading,
  );
}
