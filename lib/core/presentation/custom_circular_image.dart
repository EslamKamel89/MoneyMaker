import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    required this.placeholderAssetPath,
    required this.networkImagePath,
    this.margin,
    this.size = 60,
  });

  final double size;
  final String placeholderAssetPath;
  final EdgeInsetsGeometry? margin;
  final String networkImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      margin: margin,
      // padding: EdgeInsets.all(5.w),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: FadeInImage.assetNetwork(
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              placeholderAssetPath,
              fit: BoxFit.fill,
              height: size.w,
            );
          },
          fit: BoxFit.fill,
          height: size.w,
          placeholder: placeholderAssetPath,
          image: networkImagePath),
    );
  }
}
