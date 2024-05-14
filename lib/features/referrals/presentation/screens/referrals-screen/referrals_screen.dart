import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/presentation/custom_scaffold.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/referrals/presentation/screens/add-referrals/add_referrals_screen.dart';

class ReferralsScreen extends StatelessWidget {
  const ReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(seconds: 1),
      initialIndex: 0,
      child: CustomScaffold(
        title: 'Referrals',
        bottom: TabBar(
          dividerColor: Clr.f,
          indicatorColor: Clr.f,
          labelColor: Clr.f,
          unselectedLabelColor: Clr.b,
          indicatorWeight: 5,
          tabs: [
            Tab(
              icon: const Icon(Icons.history),
              child: Txt.bodyMeduim('Your Referrals'),
            ),
            Tab(
              icon: const Icon(Icons.add),
              child: Txt.bodyMeduim('Add Referrals'),
            ),
          ],
        ),
        child: TabBarView(
          children: [
            Center(child: Txt.bodyMeduim('History')),
            const AddReferralsScreen(),
          ],
        ),
      ),
    );
  }
}
