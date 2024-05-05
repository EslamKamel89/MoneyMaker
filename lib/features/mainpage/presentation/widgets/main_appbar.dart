import 'package:flutter/material.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/presentation/circular_image.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';

AppBar mainAppBar({
  required String title,
  required BuildContext context,
  bool automaticallyImplyLeading = true,
  bool transparent = false,
}) {
  return AppBar(
    // title: Txt.headlineMeduim(title),
    leading: CircularImage(
      imageName: AppImages.accountHeader,
    ),
    title: Txt.bodyMeduim(title.isEmpty ? 'Welcome, Eslam' : title, color: Colors.white),
    // toolbarHeight: 70.w,
    backgroundColor: transparent ? Colors.transparent : Clr.d,
    automaticallyImplyLeading: automaticallyImplyLeading,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
