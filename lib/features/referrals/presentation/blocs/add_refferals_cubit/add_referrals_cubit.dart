import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/data/RefferalsRepo.dart';

part 'add_referrals_state.dart';

class AddReferralsCubit extends Cubit<AddReferralsState> {
  final RefferalsRepo refferalRepo;
  AddReferralsCubit({required this.refferalRepo}) : super(AddReferralsInitial());
  String? countryMobileCode;

  XFile? uploadImageXFile;
  XFile? uploadIdDoucmentXFileOne;
  XFile? uploadIdDoucmentXFileTwo;
  File? uploadImageFile;
  File? uploadIdDocumentFileOne;
  File? uploadIdDocumentFileTwo;

  bool isUploadPassport = true;
  bool isTermsApproved = false;

  void updateUserImage() {
    if (isClosed) {
      return;
    }
    emit(UpdateUserImageReferralsState());
  }

  void updateDocumentImage() {
    if (isClosed) {
      return;
    }
    emit(UpdateDoucumentImageReferralsState());
  }

  Future addRefferal({
    required String userName,
    required String fullName,
    String gender = 'male',
    required String email,
    required String mobile,
    required String password,
    required XFile? profileXFile,
    required XFile passportXFile,
    required XFile? passportBackXFile,
  }) async {
    if (isClosed) {
      return null;
    }
    emit(AddReferralLoadingState());
    final response = await refferalRepo.addRefferal(
      userName: userName,
      fullName: fullName,
      gender: gender,
      email: email,
      // mobile: "${countryMobileCode ?? '+20'} + ${signUpMobileCont!.text}",
      mobile: mobile,
      password: password,
      profileXFile: profileXFile,
      passportXFile: passportXFile,
      passportBackXFile: passportBackXFile,
    );
    response.fold(
      (errorModel) {
        emit(
          AddReferralFailureState(
              errorMessage: sl<PickLanguageAndThemeCubit>().isEnglishLanguage()
                  ? errorModel.errorMessageEn ?? 'Unknown Error'
                  : errorModel.errorMessageAr ?? 'خطأ غير معروف'),
        );
      },
      (userModel) {
        emit(AddReferralSuccessState());
      },
    );
  }
}
