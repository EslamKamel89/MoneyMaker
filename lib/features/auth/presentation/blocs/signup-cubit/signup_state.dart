// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_cubit.dart';

class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthInitial extends SignupState {}

class UpdateUserImageState extends SignupState {
  final int random = Random().nextInt(100);
  @override
  List<Object?> get props => [random];
}

class UpdateDoucumentImageState extends SignupState {
  final int random = Random().nextInt(100);
  @override
  List<Object?> get props => [random];
}

final class PickVerificationMethodState extends SignupState {
  final bool isEmail;
  PickVerificationMethodState({required this.isEmail});
  @override
  List<Object?> get props => [isEmail];
}

class OtpSignupState extends SignupState {
  final String otp;
  OtpSignupState({required this.otp});
  @override
  List<Object?> get props => [otp];
}

class SignupSuccessState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupFailureState extends SignupState {
  final String errorMessage;
  SignupFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
