// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_button.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_text_field.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/gender_selection.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/pick_image_referrals_widget.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/terms_and_conditions_check_refferals.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/upload_passport_photo_referrals_screen.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/widgets/upload_passport_status_refferals.dart';

class AddReferralsScreen extends StatefulWidget {
  const AddReferralsScreen({super.key});

  @override
  State<AddReferralsScreen> createState() => _AddReferralsScreenState();
}

class _AddReferralsScreenState extends State<AddReferralsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PickImageReferralsWidget(),
          SizedBox(height: 15.h),
          AuthTextField(
            label: "FULL_NAME_IN_ENGLISH".tr(context),
            hint: "",
            suffixIcon: Icons.language,
            // controller: controller.signUpFullNameCont,
            validator: (value) {
              // return signupValidator(value: value!, minLength: 10, maxLength: 40);
              return null;
            },
          ),
          GenderSelection(
            label: "GENDER".tr(context),
            genderValue: 'male',
          ),
          AuthTextField(
            label: "USERNAME".tr(context),
            hint: "",
            suffixIcon: Icons.person_pin_rounded,
            // controller: controller.signUpUserNameCont,
            validator: (value) {
              // return signupValidator(value: value!, minLength: 3, maxLength: 15);
              return null;
            },
          ),
          AuthTextField(
            label: "MOBILE".tr(context),
            hint: "",
            suffixIcon: Icons.mobile_friendly_sharp,
            // controller: controller.signUpMobileCont,
            isMobile: true,
            validator: (value) {
              // return signupValidator(value: value!, minLength: 10, maxLength: 20);
              return null;
            },
          ),
          AuthTextField(
            label: "EMAIL".tr(context),
            hint: "",
            suffixIcon: Icons.email,
            // controller: controller.signUpEmailCont,
            validator: (value) {
              // return signupValidator(value: value!, isEmail: true);
              return null;
            },
          ),
          AuthTextField(
            label: "PASSWORD".tr(context),
            hint: "ENTER_YOUR_PASSWORD".tr(context),
            suffixIcon: Icons.remove_red_eye_outlined,
            allowObsecure: true,
            // controller: controller.signUpPassOneCont,
            validator: (value) {
              // return signupValidator(
              // value: value!, isPassword: true, anotherPass: controller.signUpPassTwoCont!.text);
              return null;
            },
          ),
          AuthTextField(
            label: "PASSWORD CONFIRMATION".tr(context),
            hint: "RE_ENTER_PASSWORD".tr(context),
            suffixIcon: Icons.remove_red_eye_outlined,
            allowObsecure: true,
            // controller: controller.signUpPassTwoCont,
            validator: (value) {
              // return signupValidator(
              // value: value!, isPassword: true, anotherPass: controller.signUpPassOneCont!.text);
              return null;
            },
          ),
          const Divider(),
          SizedBox(height: 10.h),
          UploadPassportPhotoReferrals(scaffoldKey: scaffoldKey),
          const Align(
            alignment: Alignment.topLeft,
            child: UploadPassportStatusRefferals(),
          ),
          SizedBox(height: 10.h),
          const Divider(),
          SizedBox(height: 10.h),
          ...termsAndConditionsCheckRefferals(context),
          const Divider(),
          SizedBox(height: 10.h),
          AuthButton(
            buttonTitle: "CREATE_ACCOUNT".tr(context),
            onTap: () {},
          ),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
