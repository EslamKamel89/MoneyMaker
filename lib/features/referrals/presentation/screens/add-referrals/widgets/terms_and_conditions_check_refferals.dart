import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';

List<Widget> termsAndConditionsCheckRefferals(BuildContext context) {
  return [
    Row(
      children: [
        SizedBox(width: 15.w),
        Txt.displayMeduim("READ_TERMS".tr(context)),
        SizedBox(width: 5.w),
        Builder(builder: (context) {
          // context.watch<PickLanguageAndThemeCubit>();
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesNames.termsAndConditions);
            },
            child: Txt.bodyMeduim(
              "HERE".tr(context),
              color: Clr.iconGoldColor,
            ),
          );
        }),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const TermsAndConditionsCheckBoxRefferals(),
        Txt.displayMeduim("AGREE_TERMS".tr(context)),
      ],
    ),
  ];
}

class TermsAndConditionsCheckBoxRefferals extends StatefulWidget {
  const TermsAndConditionsCheckBoxRefferals({
    super.key,
  });

  @override
  State<TermsAndConditionsCheckBoxRefferals> createState() => _TermsAndConditionsCheckBoxRefferalsState();
}

class _TermsAndConditionsCheckBoxRefferalsState extends State<TermsAndConditionsCheckBoxRefferals> {
  @override
  Widget build(BuildContext context) {
    // context.watch<PickLanguageAndThemeCubit>();
    return Checkbox(
      checkColor: Clr.c,
      fillColor: MaterialStatePropertyAll(Clr.d),
      // value: SingnupScreen.approveTerms,
      value: false,
      onChanged: (bool? value) {
        // SingnupScreen.approveTerms = value!;
        setState(() {});
      },
    );
  }
}
