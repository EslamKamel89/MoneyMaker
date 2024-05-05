import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/api/end_points.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/blocs/singin-cubit/singin_cubit.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/profile/presentation/widgets/password_text_field_user_profile.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    final signinController = context.read<SigninCubit>();
    return CustomScaffold(
      title: "USER_PROFILE".tr(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: double.infinity, height: 5.h),
            const UserProfilePhoto(),
            SizedBox(height: 30.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Txt.bodyMeduim('E-Mail', fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Txt.bodyMeduim(signinController.userModel?.email ?? 'jon_doe@example.com', color: Clr.a),
            ),
            SizedBox(height: 15.h),
            Divider(color: Clr.f),
            SizedBox(height: 15.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Txt.bodyMeduim('Phone Number', fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Txt.bodyMeduim(signinController.userModel?.mobile ?? '+20123456789', color: Clr.a),
            ),
            SizedBox(height: 15.h),
            Divider(color: Clr.f),
            SizedBox(height: 15.h),
            const ChangePasswordUserProfile(),
            // SizedBox(height: 15.h),
            Divider(color: Clr.f),
            SizedBox(height: 15.h),
            const LogoutUserProfile(),
          ],
        ),
      ),
    );
  }
}

class LogoutUserProfile extends StatelessWidget {
  const LogoutUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Txt.bodyMeduim('Logout ', fontWeight: FontWeight.bold),
          DecoratedContainerUserProfile(
            child: Icon(Icons.logout, color: Clr.f, size: 20.w),
          ),
          Txt.bodyMeduim(' ?', fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}

class ChangePasswordUserProfile extends StatefulWidget {
  const ChangePasswordUserProfile({
    super.key,
  });

  @override
  State<ChangePasswordUserProfile> createState() => _ChangePasswordUserProfileState();
}

class _ChangePasswordUserProfileState extends State<ChangePasswordUserProfile> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Txt.bodyMeduim('Change Your', fontWeight: FontWeight.bold),
                InkWell(
                  onTap: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                  child: DecoratedContainerUserProfile(
                    child: Txt.bodyMeduim('Password', color: Clr.f, fontWeight: FontWeight.bold),
                  ),
                ),
                Txt.bodyMeduim(' ?', fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Visibility(
            visible: showPassword,
            child: const PasswordTextFieldUserProfile(hintText: 'Enter Your Old Password'),
          ),
          Visibility(
            visible: showPassword,
            child: const PasswordTextFieldUserProfile(hintText: 'Enter Your New Password'),
          ),
          Visibility(
            visible: showPassword,
            child: const PasswordTextFieldUserProfile(hintText: 'Re-Enter Your New Password'),
          ),
          Visibility(
            visible: showPassword,
            child: InkWell(
              onTap: () {
                showPassword = !showPassword;
                setState(() {});
              },
              child: DecoratedContainerUserProfile(
                verticalMargin: 15.h,
                child: Txt.bodyMeduim('Save Password', color: Clr.f),
              ),
            ),
          ),
          Visibility(visible: !showPassword, child: SizedBox(height: 15.h)),
        ],
      ),
    );
  }
}

class DecoratedContainerUserProfile extends StatelessWidget {
  const DecoratedContainerUserProfile({super.key, required this.child, this.verticalMargin});
  final Widget child;
  final double? verticalMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: verticalMargin ?? 0),
      decoration: BoxDecoration(
        border: Border.all(color: Clr.f, width: 1.w),
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: child,
    );
  }
}

class UserProfilePhoto extends StatelessWidget {
  const UserProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signinController = context.read<SigninCubit>();
    return Builder(builder: (context) {
      final double size = 200.w;
      return Material(
        shape: const CircleBorder(),
        elevation: 5,
        child: Container(
          width: size,
          height: size,
          // margin: EdgeInsets.only(left: 15.w),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(size),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: signinController.userModel == null
                  ? AssetImage(AppImages.accountHeader) as ImageProvider
                  : NetworkImage('${EndPoint.uploadUser}${signinController.userModel?.profile}'),
              // : const NetworkImage('${EndPoint.uploadUser}1714839421.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      );
    });
  }
}
