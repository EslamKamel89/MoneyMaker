import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageSlider extends StatefulWidget {
  const CustomImageSlider({
    super.key,
    required this.bannerImages,
  });

  final List<String> bannerImages;

  @override
  State<CustomImageSlider> createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> imageList = widget.bannerImages
        .map(
          (path) => LayoutBuilder(builder: (context, constrains) {
            return Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20.w),
              // shadowColor: Clr.d,
              child: Container(
                height: 150.h,
                width: constrains.maxWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
                ),
              ),
            );
          }),
        )
        .toList();
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: CarouselSlider(
          items: imageList,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayInterval: const Duration(seconds: 10),
            enlargeCenterPage: true,
            aspectRatio: 2,
            pauseAutoPlayOnTouch: true,
            enlargeFactor: 10,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            height: 150.h,
            onPageChanged: (index, reason) {
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
