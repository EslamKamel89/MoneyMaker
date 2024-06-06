import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';

class PaymentMethodDisplay extends StatelessWidget {
  const PaymentMethodDisplay({
    super.key,
    required this.paymentModel,
  });

  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      // shape: const CircleBorder(),
      elevation: 5,
      borderRadius: BorderRadius.circular(20.w),
      color: Clr.d,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Colors.red,
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                EndPoint.uploadPayment + (paymentModel.image ?? ''),
                // loadingBuilder: (context, child, imageChunck) {
                //   // imageChunck.
                //   return const CircularProgressIndicator();
                // },
                errorBuilder: (context, error, stackTrace) {
                  return Txt.bodyMeduim('Image Not Found');
                },
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Txt.bodyMeduim(paymentModel.name ?? 'Unknown', textAlign: TextAlign.center, color: Colors.white),
        ],
      ),
    );
  }
}
