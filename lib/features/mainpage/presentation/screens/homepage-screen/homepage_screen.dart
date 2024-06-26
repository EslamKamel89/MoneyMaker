import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/functions/format_currency.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/mainpage/data/advertise_repo_implement.dart';
import 'package:trading/features/mainpage/presentation/blocs/mainpage_cubit/mainpage_cubit.dart';
import 'package:trading/features/mainpage/presentation/widgets/custom_image_slider.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/notifications-news-certifications/presentation/blocs/news-cubit/news_cubit.dart';
import 'package:trading/features/notifications-news-certifications/presentation/widgets/news_widget.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final themeCont = context.watch<PickLanguageAndThemeCubit>();
    final newsCubit = context.read<NewsCubit>()..getNews();
    Clr.init();
    return BlocProvider(
      create: (context) => MainpageCubit(
        advertiseRepo: sl<AdvertiseRepo>(),
        authRepo: sl<AuthRepo>(),
      )
        ..getAdvertise()
        ..getUserData(),
      child: Builder(
        builder: (context) {
          final controller = context.read<MainpageCubit>();
          // controller.getUserData();
          // controller.getAdvertise();
          return Scaffold(
            appBar: mainAppBar(title: '', context: context),
            key: scaffoldKey,
            endDrawer: const AppDrawer(),
            // backgroundColor: Colors.transparent,
            body: SafeArea(
              child: BlocBuilder<MainpageCubit, MainpageState>(
                buildWhen: (previous, current) {
                  return true;
                },
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.getUserData();
                      await controller.getAdvertise();
                      await newsCubit.getNews();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 550.h,
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25.w),
                                child: const NewsWiget(showNews: true),
                              ),
                              SizedBox(height: 10.h),
                              const CustomImageSlider(),
                              SizedBox(height: 10.h),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: MainpageChart(
                                    borderColor: Theme.of(context).scaffoldBackgroundColor,
                                    mainColor: Theme.of(context).scaffoldBackgroundColor,
                                    sectionColor:
                                        themeCont.isLightTheme() ? const Color(0xFFE4C59E) : const Color(0xFF322C2B),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
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
    final controller = context.read<MainpageCubit>();
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
                children: [
                  Txt.bodyMeduim("WEEKLY_PROFIT".tr(context)),
                  Txt.displayMeduim(
                    formatCurrency(controller.userModel?.weekly),
                  ),
                ],
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
                  children: [
                    Txt.bodyMeduim("ACCOUNT".tr(context)),
                    Txt.displayMeduim(formatCurrency(controller.userModel?.balance)
                        // '\$15482.2',
                        ),
                  ],
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
                  children: [
                    Txt.displayMeduim(
                      formatCurrency(controller.userModel?.daily),
                      // '\$15482.2',
                    ),
                    Txt.bodyMeduim("DAILY_PROFIT".tr(context)),
                  ],
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
                  children: [
                    Txt.displayMeduim(formatCurrency(controller.userModel?.referral)
                        // '\$15482.2',
                        ),
                    Txt.bodyMeduim("REFERELS".tr(context)),
                  ],
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
                child: CustomChartTwo(
                  sectionColor: sectionColor,
                  dailyProfitPercent: showGraphRatio(
                    numerator: controller.userModel?.daily,
                    denominator: controller.userModel?.balance,
                  ),
                  referallProfitPercent: showGraphRatio(
                    numerator: controller.userModel?.referral,
                    denominator: controller.userModel?.balance,
                  ),
                  profitDollar: 1200,
                )),
          )
        ],
      ),
    );
  }
}

class CustomChartTwo extends StatefulWidget {
  const CustomChartTwo({
    super.key,
    required this.sectionColor,
    required this.dailyProfitPercent,
    required this.referallProfitPercent,
    required this.profitDollar,
  });
  final Color sectionColor;
  final double dailyProfitPercent;
  final double referallProfitPercent;
  final double profitDollar;
  @override
  State<CustomChartTwo> createState() => _CustomChartTwoState();
}

class _CustomChartTwoState extends State<CustomChartTwo> {
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return Center(
        child: SfCircularChart(
      backgroundColor: Colors.transparent,
      key: GlobalKey(),
      // legend: Legend(
      //     toggleSeriesVisibility: false,
      //     isVisible: false,
      //     iconHeight: 20,
      //     iconWidth: 20,
      //     overflowMode: LegendItemOverflowMode.wrap),
      // title: const ChartTitle(text: 'Monthly steps count tracker'),
      // annotations: const <CircularChartAnnotation>[
      //   CircularChartAnnotation(
      //     height: '45%',
      //     width: '65%',
      //     widget: Column(
      //       children: <Widget>[
      //         Padding(
      //             padding: EdgeInsets.only(top: 15),
      //             child: Text('Goal -', style: TextStyle(fontWeight: FontWeight.bold))),
      //         Padding(padding: EdgeInsets.only(top: 10)),
      //         Text('6k steps/day', softWrap: false, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
      //       ],
      //     ),
      //   ),
      // ],
      series: <RadialBarSeries<ChartData, String>>[
        RadialBarSeries<ChartData, String>(
          maximumValue: 1,
          radius: '100%',
          gap: '3%',
          dataSource: [
            ChartData('Referals', widget.referallProfitPercent, Clr.a, 'Referals'),
            ChartData('Daily Profit', widget.dailyProfitPercent, Clr.f, 'Daily Profit'),
          ],
          // cornerStyle: CornerStyle.bothCurve,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelMapper: (ChartData data, _) => data.text,
          trackColor: Colors.transparent,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            // color: Colors.transparent,
            textStyle: TextStyle(
              color: themeController.isLightTheme() ? Colors.black : Colors.white,
            ),
          ),
        )
      ],
      // tooltipBehavior: _tooltipBehavior,
      // onTooltipRender: (TooltipArgs args) {
      //   final NumberFormat numberFormat = NumberFormat.compactCurrency(
      //     decimalDigits: 2,
      //     symbol: '',
      //   );
      //   // ignore: cast_nullable_to_non_nullable
      //   args.text = chartData![args.pointIndex as int].text +
      //       ' : ' +
      //       numberFormat
      //           // ignore: cast_nullable_to_non_nullable
      //           .format(chartData![args.pointIndex as int].y);
      // }
    ));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color, this.text);

  final String x;
  final num? y;
  final Color color;
  final String text;
}

double showGraphRatio({
  required double? numerator,
  required double? denominator,
}) {
  if (denominator == null || numerator == null || denominator == 0) {
    return 0.05;
  } else {
    double result = numerator / denominator;
    return result > 1 ? 1 : result;
  }
}
