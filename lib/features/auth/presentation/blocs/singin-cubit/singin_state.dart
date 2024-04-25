part of 'singin_cubit.dart';

sealed class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

final class SinginInitial extends SigninState {}

class PickResetPasswordMethodState extends SigninState {
  final bool isEmail;
  const PickResetPasswordMethodState({required this.isEmail});
  @override
  List<Object> get props => [isEmail];
}

class OtpForgetState extends SigninState {
  final String otp;
  const OtpForgetState({required this.otp});
  @override
  List<Object> get props => [otp];
}
