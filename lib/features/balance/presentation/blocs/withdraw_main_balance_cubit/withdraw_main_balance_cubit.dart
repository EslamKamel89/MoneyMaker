import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';

part 'withdraw_main_balance_state.dart';

class WithdrawMainBalanceCubit extends Cubit<WithdrawMainBalanceState> {
  final PaymentRepo paymentRepo;

  WithdrawMainBalanceCubit({required this.paymentRepo}) : super(WithdrawMainBalanceInitial());

  Future getAllPaymentMethod() async {
    emit(WithdrawMainBalanceLoadingState());
    final response = await paymentRepo.getPaymentMehods();
    response.fold(
      (errorModel) {
        emit(WithdrawMainBalanceFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(WithdrawMainBalanceSuccessState(allPayments: allPayments));
      },
    );
  }
}
