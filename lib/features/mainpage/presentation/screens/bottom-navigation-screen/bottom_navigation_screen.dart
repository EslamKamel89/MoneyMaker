import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/auth/presentation/screens/auth-widgets/auth_drawer.dart';
import 'package:trading/features/chat/presentation/screens/chat-screen/chat_screen.dart';
import 'package:trading/features/mainpage/presentation/screens/homepage-screen/homepage_screen.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';
import 'package:trading/features/support/presentation/screens/support-screen/support_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key, this.args});
  final Map? args;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _page = 1;
  int _tempIndex = 1;
  @override
  void initState() {
    if (widget.args == null) {
      _page = 1;
    } else {
      _page = widget.args!['index'] ?? 1;
    }
    if (_page != 1) {
      _tempIndex = _page;
      _page = 1;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        _page = _tempIndex;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: authAppBar(
      //   context: context,
      //   title: "",
      //   automaticallyImplyLeading: false,
      // ),
      endDrawer: const AuthDrawer(),
      bottomNavigationBar: Builder(builder: (context) {
        context.watch<PickLanguageAndThemeCubit>();
        return CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Clr.d,
          color: Clr.d,
          animationDuration: const Duration(seconds: 1),
          index: _page,
          items: [
            Icon(Icons.help_outline_outlined, size: 30.w, color: Clr.c),
            Icon(Icons.home_outlined, size: 30.w, color: Clr.c),
            Icon(Icons.chat_outlined, size: 30.w, color: Clr.c),
          ],
          onTap: (index) {
            _page = index;
            setState(() {});
          },
        );
      }),
      body: [
        SupportScreen(),
        HomeScreen(),
        ChatScreen(),
      ].elementAt(_page),
    );
  }
}
