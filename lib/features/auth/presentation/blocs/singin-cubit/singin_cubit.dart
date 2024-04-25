import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'singin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SinginInitial());

  TextEditingController? emailOrMobileCont;
  TextEditingController? passwordCont;

  TextEditingController? resetPasswordOneCont;
  TextEditingController? resetPasswordTwoCont;

  TextEditingController? emailOrMobileVerifyMethodCont;

  bool isResetPasswordMethodEmail = true;

  initSignin() {
    emailOrMobileCont = TextEditingController();
    passwordCont = TextEditingController();
  }

  disposeSignin() async {
    // return null;
    emailOrMobileCont!.dispose();
    passwordCont!.dispose();
  }

  initResetPassord() {
    resetPasswordOneCont = TextEditingController();
    resetPasswordTwoCont = TextEditingController();
  }

  disposeResetPassord() async {
    // return null;
    resetPasswordOneCont!.dispose();
    resetPasswordTwoCont!.dispose();
  }

  initPickVerifyMethod() {
    emailOrMobileVerifyMethodCont = TextEditingController();
  }

  disposePickVerifyMethod() {
    emailOrMobileVerifyMethodCont!.dispose();
  }

  void pickResetPasswordMethod({required bool isEmail}) {
    emit(PickResetPasswordMethodState(isEmail: isEmail));
  }

  void otpForget({required String otp}) {
    emit(OtpForgetState(otp: otp));
  }
}
