import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trading/core/const-strings/app_images.dart';
import 'package:trading/core/localization/localization.dart';
import 'package:trading/core/presentation/app_drawer.dart';
import 'package:trading/features/chat/domain/models/message_model.dart';
import 'package:trading/features/chat/domain/models/user_models.dart';
import 'package:trading/features/chat/presentation/widgets/add_message.dart';
import 'package:trading/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:trading/features/mainpage/presentation/widgets/main_appbar.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<UserChat> users = UserChat.usersChatStatic;
  final String currentUserId = '1';
  final lastMessageKey = GlobalKey();
  late TextEditingController messageController;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();
  @override
  void initState() {
    sortListByDate(MessageChat.messagesChatStatic);
    messageController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PickLanguageAndThemeCubit>();
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    _scrollToTheBottom(itemScrollController, MessageChat.messagesChatStatic.length);
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.moneymakerLogo))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: mainAppBar(title: "CHAT".tr(context), context: context, transparent: false),
        endDrawer: const AppDrawer(),
        floatingActionButton: AddMessage(
          messageController: messageController,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: ScrollablePositionedList.builder(
              itemCount: MessageChat.messagesChatStatic.length + 1,
              itemScrollController: itemScrollController,
              scrollOffsetController: scrollOffsetController,
              itemPositionsListener: itemPositionsListener,
              scrollOffsetListener: scrollOffsetListener,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == MessageChat.messagesChatStatic.length) {
                  return SizedBox(height: 60.h, key: lastMessageKey);
                }
                MessageChat message = MessageChat.messagesChatStatic[index];
                return ChatBubble(message: message, currentUserId: currentUserId);
              },
            ),
          ),
        ),
      ),
    );
  }
}

void _scrollToTheBottom(ItemScrollController itemScrollController, index) async {
  await Future.delayed(const Duration(milliseconds: 500));
  itemScrollController.scrollTo(index: index, duration: const Duration(seconds: 1), curve: Curves.linear);
}

void sortListByDate(List<MessageChat> messages) {
  messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
}
