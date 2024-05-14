// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_main_balance_cubit/withdraw_main_balance_cubit.dart';
import 'package:trading/features/balance/presentation/screens/withdraw-main-balance/withdraw_main_balance_details_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawFromMainBalanceWidget extends StatelessWidget {
  const WithdrawFromMainBalanceWidget({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: sl<WithdrawMainBalanceCubit>(),
              child: WithdrawMainBalanceDetailsScreen(
                paymentModel: paymentModel,
              ),
            ),
          ),
        );
      },
      child: Material(
        // shape: const CircleBorder(),
        elevation: 5,
        borderRadius: BorderRadius.circular(20.w),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(EndPoint.uploadPayment + (paymentModel.image ?? ''))),
            borderRadius: BorderRadius.circular(20.w),
          ),
        ),
      ),
    );
  }
}
