import 'package:flutter/material.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';

class WithdrawHistoryDetailsScreen extends StatelessWidget {
  const WithdrawHistoryDetailsScreen({super.key, required this.depositHistory});
  final TransactionHistoryModel depositHistory;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Withdraw History Details',
      child: Container(),
    );
  }
}
