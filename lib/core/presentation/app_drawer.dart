import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/presentation/pick_language_selector.dart';
import 'package:trading/core/presentation/pick_theme_selector.dart';
import 'package:trading/core/routing/app_routes_names.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickLanguageAndThemeCubit, PickLanguageAndThemeState>(
      builder: (context, state) {
        PickLanguageAndThemeCubit controller = context.watch<PickLanguageAndThemeCubit>();
        return Drawer(
          child: Container(
            color: controller.isLightTheme() ? Clr.eLight : Clr.eDark,
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    AppImages.moneymakerLogo,
                    height: 100.h,
                    fit: BoxFit.fill,
                  ),
                ),
                ...drawerNavigationButtons(
                  iconData: Octicons.diff_added,
                  title: 'Add To Balance',
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.addBalance, (route) => false);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: Octicons.diff_removed,
                  title: 'Withdrawal from main balance',
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.withdrawMainBalance, (route) => false);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.calendar,
                  title: 'Withdrawal from weekly balance',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(AppRoutesNames.withdrawWeeklyBalance, (route) => false);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: Octicons.person,
                  title: 'User Profile',
                  onTap: () {},
                ),
                ...drawerNavigationButtons(
                  iconData: Linecons.money,
                  title: 'Transactions',
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesNames.transactions, (route) => false);
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.newspaper,
                  title: 'Notifications and news',
                  onTap: () {},
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.help,
                  title: 'Support',
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutesNames.bottomNavigationScreen,
                      (route) => false,
                      arguments: {'index': 0},
                    );
                  },
                ),
                ...drawerNavigationButtons(
                  iconData: FontAwesome.chat,
                  title: 'Chat',
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutesNames.bottomNavigationScreen,
                      (route) => false,
                      arguments: {'index': 2},
                    );
                  },
                ),
                SizedBox(height: 10.h),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: PickLanguageSelector(resize: 0.6)),
                    Center(child: PickThemeSelector(resize: 0.6)),
                  ],
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(AppRoutesNames.testScreen);
                //   },
                //   child: Txt.bodyMeduim("App Colors"),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<Widget> drawerNavigationButtons({
  required IconData iconData,
  required String title,
  void Function()? onTap,
}) {
  return [
    Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Clr.f))),
      child: ListTile(
        leading: Icon(
          iconData,
          size: 20.w,
        ),
        title: Txt.displayMeduim(title, size: 12.sp),
        onTap: onTap,
      ),
    ),
    // const Divider(),
  ];
}
