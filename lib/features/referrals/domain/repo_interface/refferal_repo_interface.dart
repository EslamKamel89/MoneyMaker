import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/errors/error_model.dart';

abstract class RefferalsRepoInterface {
  Future<Either<ErrorModel, int>> addRefferal({
    required String userName,
    required String fullName,
    required String gender,
    required String email,
    required String mobile,
    required String password,
    required XFile? profileXFile,
    required XFile passportXFile,
    required XFile? passportBackXFile,
    int levelId = 2,
  });
}
