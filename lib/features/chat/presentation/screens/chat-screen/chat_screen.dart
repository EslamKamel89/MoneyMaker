import 'package:flutter/material.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(title: '', context: context),
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      body: Center(
        child: Txt.headlineMeduim('Chat Screen'),
      ),
    );
  }
}
