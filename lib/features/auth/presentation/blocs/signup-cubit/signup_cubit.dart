import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(AuthInitial());

  TextEditingController? signUpFullNameEngCont;
  TextEditingController? signUpFullNameArbCont;
  TextEditingController? signUpUserNameCont;
  TextEditingController? signUpIdNumberCont;
  TextEditingController? signUpMobileCont;
  TextEditingController? signUpEmailCont;
  TextEditingController? signUpPassOneCont;
  TextEditingController? signUpPassTwoCont;

  XFile? uploadImageXFile;
  XFile? uploadIdDoucmentXFileOne;
  XFile? uploadIdDoucmentXFileTwo;
  File? uploadImageFile;
  File? uploadIdDocumentFileOne;
  File? uploadIdDocumentFileTwo;

  bool isVerificationMethodEmail = true;
  bool isUploadPassport = true;

  initSignUp() {
    signUpFullNameEngCont = TextEditingController();
    signUpFullNameArbCont = TextEditingController();
    signUpUserNameCont = TextEditingController();
    signUpIdNumberCont = TextEditingController();
    signUpMobileCont = TextEditingController();
    signUpEmailCont = TextEditingController();
    signUpPassOneCont = TextEditingController();
    signUpPassTwoCont = TextEditingController();
  }

  disposeSignUp() {
    signUpFullNameEngCont!.dispose();
    signUpFullNameArbCont!.dispose();
    signUpUserNameCont!.dispose();
    signUpIdNumberCont!.dispose();
    signUpMobileCont!.dispose();
    signUpEmailCont!.dispose();
    signUpPassOneCont!.dispose();
    signUpPassTwoCont!.dispose();
  }

  void updateUserImage() {
    emit(UpdateUserImageState());
  }

  void updateDocumentImage() {
    emit(UpdateDoucumentImageState());
  }

  void pickVerficationMethod({required bool isEmail}) {
    emit(PickVerificationMethodState(isEmail: isEmail));
  }

  void otpSignup({required String otp}) {
    emit(OtpSignupState(otp: otp));
  }
}
