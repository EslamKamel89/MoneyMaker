import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/widgets/deposit_history_details_info.dart';

class DepositHistoryDetailsScreen extends StatefulWidget {
  const DepositHistoryDetailsScreen({
    super.key,
    required this.depositHistory,
    this.accepted = false,
    this.waiting = false,
    this.rejected = false,
  });
  final TransactionHistoryModel depositHistory;
  final bool accepted, waiting, rejected;

  @override
  State<DepositHistoryDetailsScreen> createState() => _DepositHistoryDetailsScreenState();
}

class _DepositHistoryDetailsScreenState extends State<DepositHistoryDetailsScreen> {
  bool colapseContainer = true;
  bool showContent = false;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      colapseContainer = false;
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      showContent = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = Clr.success;
    String requestState = '';

    if (widget.accepted) {
      requestState = 'Accepted';

      statusColor = colapseContainer ? Clr.success : Clr.success.withOpacity(0.1);
    } else if (widget.waiting) {
      requestState = 'Waiting';

      statusColor = colapseContainer ? Clr.warning : Clr.warning.withOpacity(0.1);
    } else if (widget.rejected) {
      requestState = 'Rejected';

      statusColor = colapseContainer ? Clr.danger : Clr.danger.withOpacity(0.1);
    }
    // '${EndPoint.uploadUrl}${widget.depositHistory.imageOne}'.prt('network Image');
    return CustomScaffold(
      title: 'Deposit History Details',
      showBackArrow: true,
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        width: colapseContainer ? 1.w : 500.w,
        height: colapseContainer ? 1.w : 1000.h,
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: !showContent
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DepositInfoDetails(widget: widget, requestState: requestState),
                    SizedBox(height: 10.h),
                    Divider(color: Clr.f),
                    SizedBox(height: 10.h),
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w)),
                      child: Builder(
                        builder: (context) {
                          final image = Image.network(
                            '${EndPoint.uploadDepositHistory}${widget.depositHistory.imageOne}',
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Txt.bodyMeduim(
                                'Deposit Documents\nNot Found',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            fit: BoxFit.fitHeight,
                          );
                          return image;
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(color: Clr.f),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Txt.headlineMeduim('Deposit Date'),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Txt.bodyMeduim(widget.depositHistory.createdAt?.split(' ').first ?? 'Not known'),
                    ),
                    SizedBox(height: 10.h),
                    widget.rejected
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Txt.headlineMeduim('Rejection Reason'),
                          )
                        : const SizedBox(),
                    widget.rejected
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Txt.bodyMeduim(widget.depositHistory.refuseReason ?? 'Not known'),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
      ),
    );
  }
}
