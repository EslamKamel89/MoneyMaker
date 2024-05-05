import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/balance/presentation/widgets/payment_text_field.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawFromBalanceWidget extends StatelessWidget {
  const WithdrawFromBalanceWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                // height: 100,
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Clr.e,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(imagePath),
                            maxRadius: 20.w,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close, size: 20.w),
                        ),
                      ],
                    ),
                    const PaymentTextField(
                      hintText: 'Enter Account Number',
                    ),
                    SizedBox(height: 5.h),
                    const PaymentTextField(
                      hintText: 'Enter Withdraw Amount',
                      fieldType: 'number',
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () {},
                      child: const PaymentButton(title: 'Submit', icon: Icons.login),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Material(
        // shape: const CircleBorder(),
        elevation: 5,
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imagePath)),
            borderRadius: BorderRadius.circular(20.w),
          ),
        ),
      ),
    );
  }
}
