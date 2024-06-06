import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/core/utils/snackbar.dart';
import 'package:trading/features/auth/data/repo/auth_repo_implement.dart';
import 'package:trading/features/balance/domain/models/payment_method_model.dart';
import 'package:trading/features/balance/presentation/blocs/add_balance_cubit/add_balance_cubit.dart';
import 'package:trading/features/balance/presentation/widgets/payment_text_field.dart';
import 'package:trading/features/balance/presentation/widgets/paymet_button.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AddBalanceDetailsScreen extends StatefulWidget {
  const AddBalanceDetailsScreen({super.key, required this.paymentModel});
  final PaymentModel paymentModel;
  @override
  State<AddBalanceDetailsScreen> createState() => _AddBalanceDetailsScreenState();
}

class _AddBalanceDetailsScreenState extends State<AddBalanceDetailsScreen> {
  late final AddBalanceCubit addBalanceController;
  TextEditingController? transactionNumberController;
  TextEditingController? transactionAmountController;
  final GlobalKey<FormState> formKey = GlobalKey();
  DateTime? transactionDate;
  @override
  void initState() {
    addBalanceController = context.read<AddBalanceCubit>();
    transactionNumberController = TextEditingController();
    transactionAmountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    transactionNumberController = TextEditingController();
    transactionAmountController = TextEditingController();
    addBalanceController.getAllPaymentMethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    addBalanceController.resetUploadDocument();
    return BlocListener<AddBalanceCubit, AddBalanceState>(
      listener: (context, state) {
        if (state is AddBalanceDepositSuccessState) {
          customSnackBar(context: context, title: 'Add To Deposit Succeded');
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
        }
        if (state is AddBalanceFailedState) {
          customSnackBar(
            context: context,
            title: state.errorModel.errorMessageEn ?? "Couldn't complete the deposit process successfully",
            isSuccess: false,
          );
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.bottomNavigationScreen, (route) => true);
        }
      },
      child: CustomScaffold(
        showBackArrow: true,
        title: "ADD_TO_BALANCE".tr(context),
        child: Form(
          key: formKey,
          child: ListView(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(EndPoint.uploadPayment + (widget.paymentModel.image ?? '')),
                  maxRadius: 100.w,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Txt.bodyMeduim(
                  '${widget.paymentModel.name ?? ''} / ${widget.paymentModel.code ?? ''}',
                  fontWeight: FontWeight.bold,
                  color: Clr.f,
                ),
              ),
              SizedBox(height: 20.h),
              PaymentTextField(
                hintText: 'Enter Transaction Number',
                controller: transactionNumberController,
                validator: _addDepositValidator,
              ),
              SizedBox(height: 20.h),
              PaymentTextField(
                hintText: 'Enter Transaction Amount',
                fieldType: 'number',
                controller: transactionAmountController,
                validator: _addDepositValidator,
              ),
              SizedBox(height: 35.h),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () async {
                    final dateNow = DateTime.now();
                    transactionDate = await showDatePicker(
                        context: context,
                        firstDate: dateNow.subtract(const Duration(days: 30)),
                        lastDate: dateNow.add(const Duration(days: 2)));
                    addBalanceController.datePickedState(transactionDate);
                  },
                  child: BlocBuilder<AddBalanceCubit, AddBalanceState>(
                    buildWhen: (previous, current) {
                      if (current is DatePickedState) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Txt.bodyMeduim(
                            state is DatePickedState && state.transactionDate != null
                                ? state.transactionDate!.toIso8601String().split('T').first
                                : 'Pick Transaction Date',
                            color: themeController.isLightTheme() ? Clr.bDark.withOpacity(0.5) : Clr.bLight,
                            size: 14.sp,
                          ),
                          SizedBox(height: 3.h),
                          Divider(color: Clr.iconGoldColor),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await _pickImageFromGallery(context, controller: addBalanceController);
                      if (addBalanceController.uploadDocumentXFile != null) {
                        addBalanceController.uploadFromGallery();
                      }
                    },
                    child: BlocBuilder<AddBalanceCubit, AddBalanceState>(
                      builder: (context, state) {
                        return PaymentButton(
                          title: 'Attach',
                          icon: state is UploadDocumentGalleryState ? Icons.check : Icons.attach_file_outlined,
                          width: 90.w,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  InkWell(
                    onTap: () async {
                      await _pickImageFromCamera(context, controller: addBalanceController);
                      if (addBalanceController.uploadDocumentXFile != null) {
                        addBalanceController.uploadFromCamera();
                      }
                    },
                    child: BlocBuilder<AddBalanceCubit, AddBalanceState>(
                      builder: (context, state) {
                        return PaymentButton(
                          title: 'Camera',
                          icon: state is UploadDocumentCameraState ? Icons.check : Icons.camera_alt_rounded,
                          width: 90.w,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              BlocBuilder<AddBalanceCubit, AddBalanceState>(
                builder: (context, state) {
                  return state is AddBalanceDepositLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: InkWell(
                            onTap: () async {
                              // '${transactionAmountController?.text}'.prm('Check the amount Value');
                              if (formKey.currentState!.validate() &&
                                  transactionDate != null &&
                                  addBalanceController.uploadDocumentXFile != null) {
                                addBalanceController.addToBalance(
                                  paymentId: widget.paymentModel.id ?? 0,
                                  userId: (await sl<AuthRepo>().getChacedUserData())?.id ?? 0,
                                  transactionNumber: transactionNumberController?.text ?? '',
                                  amount: double.parse(transactionAmountController?.text ?? '0'),
                                  imageXFile: addBalanceController.uploadDocumentXFile!,
                                  createdAt: transactionDate?.toIso8601String() ?? '',
                                );
                                return;
                              }
                              if (transactionDate == null) {
                                customSnackBar(
                                    context: context, title: 'You Must Pick Transaction Date', isSuccess: false);
                              }
                              if (addBalanceController.uploadDocumentXFile == null) {
                                customSnackBar(
                                    context: context, title: 'You Must Upload Transaction Document', isSuccess: false);
                              }
                            },
                            child: const PaymentButton(title: 'Submit', icon: Icons.login),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _addDepositValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "You can't leave this field empty";
    } else {
      return null;
    }
  }

  Future _pickImageFromGallery(
    BuildContext context, {
    required AddBalanceCubit controller,
  }) async {
    controller.uploadDocumentXFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (controller.uploadDocumentXFile == null) {
      return;
    }
    controller.uploadDocumentFile = File(controller.uploadDocumentXFile!.path);
    // controller.updateDocumentImage();
  }

  Future _pickImageFromCamera(
    BuildContext context, {
    required AddBalanceCubit controller,
  }) async {
    controller.uploadDocumentXFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (controller.uploadDocumentXFile == null) {
      return;
    }
    controller.uploadDocumentFile = File(controller.uploadDocumentXFile!.path);
    // controller.updateDocumentImage();
  }
}
