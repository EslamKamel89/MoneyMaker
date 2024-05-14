part of 'add_balance_cubit.dart';

sealed class AddBalanceState {
  const AddBalanceState();
}

final class AddBalanceInitial extends AddBalanceState {}

final class UploadDocumentGalleryState extends AddBalanceState {}

final class UploadDocumentCameraState extends AddBalanceState {}

final class ResetUploadDocumentState extends AddBalanceState {}

final class DatePickedState extends AddBalanceState {
  DateTime? transactionDate;
  DatePickedState({required this.transactionDate});
}

final class AddBalanceLoadingState extends AddBalanceState {}

final class AddBalanceFailedState extends AddBalanceState {
  final ErrorModel errorModel;
  AddBalanceFailedState({required this.errorModel});
}

final class AddBalanceGetPaymentSuccessState extends AddBalanceState {
  final List<PaymentModel> allPayments;
  AddBalanceGetPaymentSuccessState({required this.allPayments});
}

final class AddBalanceDepositLoadingState extends AddBalanceState {}

final class AddBalanceDepositFailedState extends AddBalanceState {
  final String errorMessage;
  AddBalanceDepositFailedState({required this.errorMessage});
}

final class AddBalanceDepositSuccessState extends AddBalanceState {}
