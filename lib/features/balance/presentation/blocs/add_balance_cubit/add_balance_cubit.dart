import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/features/balance/data/payment_repo_imp.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

part 'add_balance_state.dart';

class AddBalanceCubit extends Cubit<AddBalanceState> {
  final PaymentRepo paymentRepo;
  AddBalanceCubit({required this.paymentRepo}) : super(AddBalanceInitial());

  XFile? uploadDocumentXFile;
  File? uploadDocumentFile;

  void uploadFromGallery() {
    emit(UploadDocumentGalleryState());
  }

  void uploadFromCamera() {
    emit(UploadDocumentCameraState());
  }

  void resetUploadDocument() {
    uploadDocumentFile = null;
    uploadDocumentXFile = null;
    emit(ResetUploadDocumentState());
  }

  void datePickedState(DateTime? transactionDate) {
    emit(DatePickedState(transactionDate: transactionDate));
  }

  Future getAllPaymentMethod() async {
    emit(AddBalanceLoadingState());
    final response = await paymentRepo.getPaymentMehods();
    response.fold(
      (errorModel) {
        emit(AddBalanceFailedState(errorModel: errorModel));
      },
      (allPayments) {
        emit(AddBalanceGetPaymentSuccessState(allPayments: allPayments));
      },
    );
  }

  Future addToBalance({
    required int paymentId,
    required int userId,
    required String transactionNumber,
    required double amount,
    required XFile imageXFile,
    required String createdAt,
  }) async {
    emit(AddBalanceDepositLoadingState());
    final response = await paymentRepo.addToBalance(
      paymentId: paymentId,
      userId: userId,
      transactionNumber: transactionNumber,
      amount: amount,
      imageXFile: imageXFile,
      createdAt: createdAt,
    );
    response.fold(
      (errorModel) {
        emit(
          AddBalanceDepositFailedState(
              errorMessage: sl<PickLanguageAndThemeCubit>().isEnglishLanguage()
                  ? errorModel.errorMessageEn ?? 'Unknown Error'
                  : errorModel.errorMessageAr ?? 'خطأ غير معروف'),
        );
      },
      (_) {
        emit(AddBalanceDepositSuccessState());
      },
    );
  }
}
