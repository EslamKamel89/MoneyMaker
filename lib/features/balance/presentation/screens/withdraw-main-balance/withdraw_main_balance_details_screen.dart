import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/withdraw_main_balance_cubit/withdraw_main_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/payment_text_field.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class WithdrawMainBalanceDetailsScreen extends StatefulWidget {
  const WithdrawMainBalanceDetailsScreen({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  State<WithdrawMainBalanceDetailsScreen> createState() => _WithdrawMainBalanceDetailsScreenState();
}

class _WithdrawMainBalanceDetailsScreenState extends State<WithdrawMainBalanceDetailsScreen> {
  late final WithdrawMainBalanceCubit withdrawMainBalanceController;
  TextEditingController? accountNumberController;
  TextEditingController? withdrawAmountController;
  @override
  void initState() {
    withdrawMainBalanceController = context.read<WithdrawMainBalanceCubit>();
    accountNumberController = TextEditingController();
    withdrawAmountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    accountNumberController = TextEditingController();
    withdrawAmountController = TextEditingController();
    withdrawMainBalanceController.getAllPaymentMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return CustomScaffold(
      showBackArrow: true,
      title: "WITHDRAW_FROM_MAIN_BALANCE".tr(context),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(EndPoint.uploadPayment + (widget.paymentModel.image ?? '')),
              maxRadius: 100.w,
            ),
          ),
          SizedBox(height: 20.h),
          const PaymentTextField(
            hintText: 'Enter Account Number',
          ),
          SizedBox(height: 20.h),
          const PaymentTextField(
            hintText: 'Enter Withdraw Amount',
            fieldType: 'number',
          ),
          SizedBox(height: 40.h),
          SizedBox(height: 20.h),
          Center(
            child: InkWell(
              onTap: () {},
              child: const PaymentButton(title: 'Submit', icon: Icons.login),
            ),
          )
        ],
      ),
    );
  }
}
