import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/api/upload_image_to_api.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/domain/models/transaction_history_model.dart';
import 'package:trading/features/balance/domain/models/withdraw_history_model.dart';
import 'package:trading/features/balance/domain/repo_interface/payment_repo_interface.dart';

class PaymentRepo implements PaymentRepoInterface {
  final ApiConsumer api;
  PaymentRepo({required this.api});
  @override
  Future<Either<ErrorModel, List<PaymentModel>>> getPaymentMehods() async {
    final t = 'PaymentRepo - getPaymentMehods'.prt;
    try {
      final response = await api.get(EndPoint.paymentMehods);
      final List<PaymentModel> allPaymentList = [];
      final List allPaymentJson = jsonDecode(response);
      for (var json in allPaymentJson) {
        allPaymentList.add(PaymentModel.fromJson(json));
      }
      '$allPaymentList'.prm(t);
      return Right(allPaymentList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<TransactionHistoryModel>>> getDepositHistory() async {
    final t = 'PaymentRepo - getDepositHistory'.prt;
    try {
      UserModel? userModel = await sl<AuthRepo>().getChacedUserData();
      final response = await api.get("${EndPoint.depositHistory}${userModel?.id}");
      // final response = await api.get("${EndPoint.depositHistory}5");
      final List<TransactionHistoryModel> allDepositHistoryList = [];
      final List allDepoistHistoryJson = jsonDecode(response)[ApiKey.data];
      for (var json in allDepoistHistoryJson) {
        allDepositHistoryList.add(TransactionHistoryModel.fromJson(json));
      }
      '$allDepositHistoryList'.prm(t);
      return Right(allDepositHistoryList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, int>> addToBalance({
    required int paymentId,
    required int userId,
    required String transactionNumber,
    required double amount,
    required XFile imageXFile,
    required String createdAt,
  }) async {
    final t = 'PaymentRepo - addToBalance'.prt;
    final _ = {
      ApiKey.userId: userId,
      ApiKey.paymentId: paymentId,
      ApiKey.transactionNumber: transactionNumber,
      ApiKey.amount: amount,
      // ApiKey.image: (await uploadImageToApi(imageXFile)),
      ApiKey.createdAt: createdAt,
    }.prm('t');
    try {
      final response = await api.post(
        EndPoint.addDeposit,
        data: {
          ApiKey.userId: userId,
          ApiKey.paymentId: paymentId,
          ApiKey.transactionNumber: transactionNumber,
          ApiKey.amount: amount,
          ApiKey.image: (await uploadImageToApi(imageXFile)),
          ApiKey.createdAt: createdAt,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        final int resultId = jsonDecode(response)[ApiKey.data];
        '$resultId'.prm(t);
        return Right(resultId);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, String>> withdraw({
    required int userId,
    required String accountNumber,
    required double amount,
    required String type,
    required int paymentId,
  }) async {
    final t = 'PaymentRepo - withdraw'.prt;
    try {
      final response = await api.post(
        EndPoint.withdraw,
        data: {
          ApiKey.userId: userId,
          ApiKey.accountNumber: accountNumber,
          ApiKey.paymentId: paymentId,
          ApiKey.amount: amount,
          ApiKey.type: type,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        'Withdraw from $type comptedted successfully'.prm(t);
        return const Right('success');
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }

  @override
  Future<Either<ErrorModel, List<WithdrawHistoryModel>>> getWithdrawHistory() async {
    final t = 'PaymentRepo - getWithdrawHistory'.prt;
    try {
      UserModel? userModel = await sl<AuthRepo>().getChacedUserData();
      final response = await api.get("${EndPoint.withdrawHistory}${userModel?.id}");
      // final response = await api.get("${EndPoint.depositHistory}5");
      final List<WithdrawHistoryModel> allWithdrawHistoryList = [];
      final List allWithdrawHistoryJson = jsonDecode(response)[ApiKey.data];
      for (var json in allWithdrawHistoryJson) {
        allWithdrawHistoryList.add(WithdrawHistoryModel.fromJson(json));
      }
      '$allWithdrawHistoryList'.prm(t);
      return Right(allWithdrawHistoryList);
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }
}
