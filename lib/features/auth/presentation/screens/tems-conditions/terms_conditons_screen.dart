import 'package:flutter/material.dart';
import 'package:trading/core/body-widget/body_widget.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_appbar.dart';

class TermsAndConditonsScreen extends StatelessWidget {
  const TermsAndConditonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(title: "TERMS_AND_CONDITIONS".tr(context), context: context),
      resizeToAvoidBottomInset: false,
      body: const SingleChildScrollView(
        child: BodyWidget(
          child: Column(
            children: [
              Text(
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Accusantium, facere ad explicabo, est adipisci iure minus blanditiis dignissimos, maxime necessitatibus consequatur rerum error aperiam impedit voluptatibus sint iusto? Reiciendis, architecto!"),
            ],
          ),
        ),
      ),
    );
  }
}
