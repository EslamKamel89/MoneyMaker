import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';

part 'withdraw_weekly_balance_state.dart';

class WithdrawWeeklyBalanceCubit extends Cubit<WithdrawWeeklyBalanceState> {
  final PaymentRepo paymentRepo;

  WithdrawWeeklyBalanceCubit({required this.paymentRepo}) : super(WithdrawWeeklyBalanceInitial());

  Future getAllPaymentMethod() async {
    emit(WithdrawWeeklyBalanceLoadingState());
    final response = await paymentRepo.getPaymentMehods();
    response.fold(
      (errorModel) {
        emit(WithdrawWeeklyBalanceFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(WithdrawWeeklyBalanceSuccessState(allPayments: allPayments));
      },
    );
  }
}
