import 'package:flutter/material.dart';
import 'package:trading/core/dependency-injection-container/injection_container.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class Clr {
  static Color a = aLight;
  static Color b = bLight;
  static Color c = cLight;
  static Color d = dLight;
  static Color e = eLight;
  static Color f = fLight;

  static Color aLight = const Color(0xff131315);
  static Color bLight = const Color(0xffc8aa83);
  static Color cLight = const Color(0xfffefefe);
  static Color dLight = const Color(0xff886848);
  static Color eLight = const Color(0xFFFFEDD8);
  static Color fLight = const Color(0xFFC07F00);

  static Color aDark = const Color(0xffb69467);
  static Color bDark = const Color(0xff372e26);
  static Color cDark = const Color(0xff1c2125);
  static Color dDark = const Color(0xff926840);
  static Color eDark = const Color(0xFF222831);
  static Color fDark = const Color(0xFFF6CA7B);

  static Color authFormFieldDark = const Color.fromRGBO(48, 48, 48, 1);
  static Color iconGoldColor = const Color(0xFFF6CA7B);

  static PickLanguageAndThemeCubit pickLanguageCubit = sl();
  static init() {
    if (pickLanguageCubit.isLightTheme()) {
      a = aLight;
      b = bLight;
      c = cLight;
      d = dLight;
      e = eLight;
      f = fLight;
    } else {
      a = aDark;
      b = bDark;
      c = cDark;
      d = dDark;
      e = eDark;
      f = fDark;
    }
  }
}
