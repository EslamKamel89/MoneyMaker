import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/balance/presentation/blocs/transaction-history-cubit/transaction_history_cubit.dart';
import 'package:trading/features/balance/presentation/screens/transaction-history/widgets/depoist_history_widget.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late TransactionHistoryCubit controller;
  @override
  void initState() {
    controller = context.read<TransactionHistoryCubit>();
    controller.getDepositHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(seconds: 1),
      initialIndex: 0,
      child: CustomScaffold(
        title: "TRNASACTIONS".tr(context),
        bottom: TabBar(
          dividerColor: Clr.f,
          indicatorColor: Clr.f,
          labelColor: Clr.f,
          unselectedLabelColor: Clr.b,
          indicatorWeight: 5,
          tabs: const [
            Tab(
              text: 'Withdraw History',
              icon: Icon(Icons.history),
            ),
            Tab(
              text: 'Deposit History',
              icon: Icon(Icons.add),
            ),
          ],
        ),
        child: BlocConsumer<TransactionHistoryCubit, TransactionHistoryState>(
          listener: (context, state) {
            if (state is TransactionHistorySuccessState) {
              state.allDepositHistory.prm('Fetched Deposit History Data');
            }
            if (state is TransactionHistoryFailedState) {
              customSnackBar(context: context, title: state.errorModel.errorMessageEn ?? 'Error', isSuccess: false);
            }
          },
          builder: (context, state) {
            if (state is TransactionHistoryLoadingState) {
              return const TabBarView(
                children: [
                  Center(child: CircularProgressIndicator()),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            if (state is TransactionHistorySuccessState) {
              if (state.allDepositHistory.isEmpty) {
                return TabBarView(
                  children: [
                    Center(child: Txt.bodyMeduim('No data in withdraw history')),
                    Center(child: Txt.bodyMeduim('No data in deposit history')),
                  ],
                );
              }
              return TabBarView(
                children: [
                  Center(child: Txt.bodyMeduim('Withdraw History')),
                  DepositHistoryWidget(depositHistoryList: state.allDepositHistory),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
