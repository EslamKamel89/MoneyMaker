import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.suffixIcon,
    // this.obsecureOnTap,
    this.allowObsecure = false,
    this.isMobile = false,
    this.controller,
    this.validator,
  });
  final String label;
  final String hint;
  final IconData suffixIcon;
  // final void Function()? obsecureOnTap;
  final bool allowObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isMobile;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: themeController.isLightTheme() ? Clr.b : Clr.authFormFieldDark,
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.w),
          Icon(
            widget.allowObsecure ? Icons.lock : widget.suffixIcon,
            size: 20.w,
            color: Clr.iconGoldColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              decoration: InputDecoration(
                // label: Txt.bodyMeduim(widget.label),
                hintText: widget.label,
                hintStyle: TextStyle(fontSize: 16.sp),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                suffixIcon: InkWell(
                  onTap: () {
                    if (widget.allowObsecure) {
                      isObsecure = !isObsecure;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    getIcon(),
                    size: 20.w,
                  ),
                ),
              ),
              obscureText: widget.allowObsecure == false ? false : isObsecure,
              keyboardType: widget.isMobile ? TextInputType.phone : null,
            ),
          ),
        ],
      ),
    );
  }

  IconData? getIcon() {
    if (!widget.allowObsecure) {
      return null;
    } else if (isObsecure) {
      return Icons.remove_red_eye_sharp;
    } else {
      return Icons.visibility_off_outlined;
    }
  }
}


/*

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.suffixIcon,
    // this.obsecureOnTap,
    this.allowObsecure = false,
    this.isMobile = false,
    this.controller,
    this.validator,
  });
  final String label;
  final String hint;
  final IconData suffixIcon;
  // final void Function()? obsecureOnTap;
  final bool allowObsecure;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isMobile;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          label: Txt.bodyMeduim(widget.label),
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 16.sp),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.w),
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (widget.allowObsecure) {
                isObsecure = !isObsecure;
                setState(() {});
              }
            },
            child: Icon(
              getIcon(),
              size: 20.w,
            ),
          ),
        ),
        obscureText: widget.allowObsecure == false ? false : isObsecure,
        keyboardType: widget.isMobile ? TextInputType.phone : null,
      ),
    );
  }

  IconData getIcon() {
    if (!widget.allowObsecure) {
      return widget.suffixIcon;
    } else if (isObsecure) {
      return Icons.remove_red_eye_sharp;
    } else {
      return Icons.visibility_off_outlined;
    }
  }
}


 */

/*
 ndkVersion "26.3.11579264"
     ndkVersion flutter.ndkVersion
    ndkVersion "25.1.8937393"
 */