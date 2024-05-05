import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';
import 'package:trading/features/balance/presentation/widgets/withdraw_from_balance_widget.dart';

class WithdrawWeeklyBalanceScreen extends StatelessWidget {
  const WithdrawWeeklyBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithNewsBar(
      title: "WITHDRAW_FROM_WEEKLY_BALANCE".tr(context),
      child: GridView.builder(
        itemCount: _withdrawFromWeeklyBalanceStaticData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 30.w,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.w,
        ),
        itemBuilder: (context, index) {
          return _withdrawFromWeeklyBalanceStaticData[index];
        },
      ),
    );
  }
}

List<Widget> _withdrawFromWeeklyBalanceStaticData = [
  WithdrawFromBalanceWidget(imagePath: AppImages.vodafone),
  WithdrawFromBalanceWidget(imagePath: AppImages.fawry),
  WithdrawFromBalanceWidget(imagePath: AppImages.cib),
  WithdrawFromBalanceWidget(imagePath: AppImages.visa),
  WithdrawFromBalanceWidget(imagePath: AppImages.instapay),
];
