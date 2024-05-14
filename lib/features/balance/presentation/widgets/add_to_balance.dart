// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/screens/add-balance/add_balance_details_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AddBalanceWidget extends StatefulWidget {
  const AddBalanceWidget({super.key, required this.paymentModel});
  final PaymentModel paymentModel;

  @override
  State<AddBalanceWidget> createState() => _AddBalanceWidgetState();
}

class _AddBalanceWidgetState extends State<AddBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(AppRoutesNames.addBalanceDetails, arguments: {'imagePath': widget.imagePath});
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: sl<AddBalanceCubit>(),
              child: AddBalanceDetailsScreen(paymentModel: widget.paymentModel),
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
            image: DecorationImage(image: NetworkImage(EndPoint.uploadPayment + (widget.paymentModel.image ?? ''))),
            borderRadius: BorderRadius.circular(20.w),
          ),
        ),
      ),
    );
  }
}
