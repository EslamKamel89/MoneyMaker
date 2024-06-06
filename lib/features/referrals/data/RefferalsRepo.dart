import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/api/api_consumer.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/api/upload_image_to_api.dart';
import 'package:trading/core/crud/status_request.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/errors/error_model.dart';
import 'package:trading/core/errors/exception.dart';
import 'package:trading/core/extensions/extensions.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/auth/domain/models/user_model.dart';
import 'package:trading/features/referrals/domain/repo_interface/refferal_repo_interface.dart';

class RefferalsRepo implements RefferalsRepoInterface {
  ApiConsumer api;
  RefferalsRepo({required this.api});
  @override
  Future<Either<ErrorModel, int>> addRefferal(
      {required String userName,
      required String fullName,
      required String gender,
      required String email,
      required String mobile,
      required String password,
      required XFile? profileXFile,
      required XFile passportXFile,
      required XFile? passportBackXFile,
      int levelId = 2}) async {
    final t = 'AddRefferalsRepos - addRefferal'.prt;
    try {
      final UserModel? userModel = await sl<AuthRepo>().getChacedUserData();
      if (userModel == null) {
        return left(ErrorModel(
          error: true,
          errorMessageAr: 'لا يوج مستخدم أتم عملية التسجيل بالتطبيق',
          errorMessageEn: 'No user is signed in',
          status: 'fail',
          statusRequest: StatusRequest.error,
        ));
      }
      final response = await api.post(
        EndPoint.addRefferal,
        data: {
          ApiKey.userName: userName,
          ApiKey.fullName: fullName,
          ApiKey.gender: gender,
          ApiKey.email: email,
          ApiKey.mobile: mobile,
          ApiKey.password: password,
          ApiKey.levelId: levelId,
          ApiKey.userId: userModel.id,
          ApiKey.profile: profileXFile != null ? (await uploadImageToApi(profileXFile)) : null,
          ApiKey.passport: (await uploadImageToApi(passportXFile)),
          ApiKey.passportBack: passportBackXFile != null ? (await uploadImageToApi(passportBackXFile)) : null,
        },
        isFormData: true,
      );
      final ErrorModel? errorModel;
      errorModel = ErrorModel.checkResponse(jsonDecode(response));
      if (errorModel != null) {
        errorModel.errorMessageEn.prm(t);
        return Left(errorModel);
      } else {
        'Add Refferal Succeded'.prm(t);
        return const Right(1);
      }
    } on ServerException catch (e) {
      e.errModel.errorMessageEn.prm(t);
      return Left(e.errModel);
    }
  }
}
