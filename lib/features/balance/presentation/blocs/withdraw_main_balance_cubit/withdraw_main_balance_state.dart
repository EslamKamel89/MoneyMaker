part of 'withdraw_main_balance_cubit.dart';

sealed class WithdrawMainBalanceState extends Equatable {
  const WithdrawMainBalanceState();

  @override
  List<Object> get props => [];
}

final class WithdrawMainBalanceInitial extends WithdrawMainBalanceState {}

final class WithdrawMainBalanceLoadingState extends WithdrawMainBalanceState {}

final class WithdrawMainBalanceFailedState extends WithdrawMainBalanceState {
  final ErrorModel errorModel;
  const WithdrawMainBalanceFailedState({required this.errorModel});
}

final class WithdrawMainBalanceSuccessState extends WithdrawMainBalanceState {
  final List<PaymentModel> allPayments;
  const WithdrawMainBalanceSuccessState({required this.allPayments});
}
