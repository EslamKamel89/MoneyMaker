import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/const-strings/app_strings.dart';
import 'package:trading/features/mainpage/presentation/widgets/section_background_border.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class NewsWiget extends StatelessWidget {
  const NewsWiget({
    super.key,
    this.showNews = true,
  });
  final bool showNews;
  @override
  Widget build(BuildContext context) {
    final themeCont = context.watch<PickLanguageAndThemeCubit>();
    if (!showNews) {
      return const SizedBox();
    }
    return SectionBackgroundAndBorder(
      // height: 40.h,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Agne',
        ),
        textAlign: TextAlign.center,
        child: AnimatedTextKit(
          animatedTexts: [
            ...typeTextAnimation(
              themeCont.isEnglishLanguage() ? AppStrings.NEWS : AppStrings.NEWS_ARABIC,
              themeCont.isEnglishLanguage() ? 6 : 7,
            ),
          ],
          onTap: () {},
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      ),
    );
  }
}

List<TypewriterAnimatedText> typeTextAnimation(String message, int wordNumber) {
  List<String> wordsList = (message).split(" ");
  List<TypewriterAnimatedText> resultArray = [];
  for (var i = 0; i < wordsList.length; i += wordNumber) {
    bool breakOut = false;
    if (i + wordNumber >= wordsList.length) {
      wordsList.addAll(List.generate(wordNumber, (index) => ""));
      breakOut = true;
    }
    resultArray.add(
      TypewriterAnimatedText(
        List.generate(wordNumber, (index) => wordsList[index + i]).join(" "),
        speed: const Duration(milliseconds: 150),
      ),
    );
    if (breakOut) {
      break;
    }
  }
  return resultArray;
}
