import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/mainpage/presentation/widgets/custom_image_slider.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/notifications-news/presentation/widgets/news_widget.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final List<String> bannerImages = [
    AppImages.banner1,
    AppImages.banner2,
    AppImages.banner3,
  ];
  @override
  Widget build(BuildContext context) {
    final themeCont = context.watch<PickLanguageAndThemeCubit>();
    Clr.init();
    return Scaffold(
      appBar: mainAppBar(title: '', context: context),
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: const NewsWiget(showNews: true),
            ),
            SizedBox(height: 10.h),
            CustomImageSlider(bannerImages: bannerImages),
            SizedBox(height: 10.h),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: MainpageChart(
                  borderColor: Theme.of(context).scaffoldBackgroundColor,
                  mainColor: Theme.of(context).scaffoldBackgroundColor,
                  sectionColor: themeCont.isLightTheme() ? const Color(0xFFE4C59E) : const Color(0xFF322C2B),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class MainpageChart extends StatelessWidget {
  const MainpageChart({
    super.key,
    required this.mainColor,
    required this.borderColor,
    required this.sectionColor,
  });
  final Color mainColor;
  final Color borderColor;
  final Color sectionColor;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: sectionColor,
              borderRadius: BorderRadius.circular(50.w),
              border: Border.all(
                width: 10.w,
                color: borderColor,
              ),
            ),
          ),
          Positioned(
            top: 30.w,
            left: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Txt.bodyMeduim("WEEKLY_PROFIT".tr(context)), Txt.displayMeduim('\$155.2')],
              ),
            ),
          ),
          Positioned(
            top: 30.w,
            right: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Txt.bodyMeduim("ACCOUNT".tr(context)), Txt.displayMeduim('\$15482.2')],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.w,
            left: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Txt.displayMeduim('\$15482.2'), Txt.bodyMeduim("DAILY_PROFIT".tr(context))],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30.w,
            right: 30.w,
            child: Container(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Txt.displayMeduim('\$15482.2'), Txt.bodyMeduim("REFERELS".tr(context))],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: 10.w,
                  height: constraints.maxHeight,
                  color: borderColor,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 10.w,
                  width: constraints.maxWidth,
                  color: borderColor,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                height: 250.w,
                width: 250.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor,
                  border: Border.all(
                    width: 10.w,
                    color: borderColor,
                  ),
                ),
                child: CustomChart(
                  sectionColor: sectionColor,
                  value: 80,
                  profitDollar: 1200,
                )),
          )
        ],
      ),
    );
  }
}

class CustomChart extends StatefulWidget {
  const CustomChart({super.key, required this.sectionColor, required this.value, required this.profitDollar});
  final Color sectionColor;
  final double value;
  final double profitDollar;
  @override
  State<CustomChart> createState() => _CustomChartState();
}

class _CustomChartState extends State<CustomChart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: true,
              startAngle: 0,
              endAngle: 360,
              radiusFactor: 0.9,
              axisLineStyle: AxisLineStyle(
                thickness: 0.1,
                color: widget.sectionColor,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: widget.value,
                  width: 0.05,
                  color: Clr.d,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 20,
                  // animationType: AnimationType.ease,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(widget: Txt.bodyMeduim('Daily Profit \$${widget.profitDollar.toStringAsFixed(0)}'))
              ])
        ],
      ),
    );
  }
}
