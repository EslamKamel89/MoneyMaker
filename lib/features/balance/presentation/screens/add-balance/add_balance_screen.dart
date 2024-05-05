import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';
import 'package:trading/features/balance/presentation/widgets/add_to_balance.dart';

class AddBalanceScreen extends StatelessWidget {
  const AddBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithNewsBar(
      title: "ADD_TO_BALANCE".tr(context),
      child: GridView.builder(
        itemCount: addToBalanceStaticData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 30.w,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.w,
        ),
        itemBuilder: (context, index) {
          return addToBalanceStaticData[index];
        },
      ),
    );
  }
}

List<Widget> addToBalanceStaticData = [
  AddBalanceWidget(imagePath: AppImages.vodafone),
  AddBalanceWidget(imagePath: AppImages.fawry),
  AddBalanceWidget(imagePath: AppImages.cib),
  AddBalanceWidget(imagePath: AppImages.visa),
  AddBalanceWidget(imagePath: AppImages.instapay),
];
