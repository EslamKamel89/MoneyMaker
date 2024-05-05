import 'package:flutter/material.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold_with_news_bar.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWithNewsBar(
      title: "TRNASACTIONS".tr(context),
      child: Container(
        color: Colors.grey,
      ),
    );
  }
}
