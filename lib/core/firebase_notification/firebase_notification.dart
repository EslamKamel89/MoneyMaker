import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:trading/core/extensions/extensions.dart';

abstract class FirebaseHelper {
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    const t = "firebaseMessagingBackgroundHandler - FirebaseHelper";
    message.messageId.prm(t);
  }

  static void requestPermisson(BuildContext context) async {
    const t = "requestPermisson - FirebaseHelper";
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      announcement: false,
      provisional: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      'User granted Permisson'.prm(t);
    } else {
      "User didn't give the application permisson".prm(t);
    }
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        message.notification!.title.prm('$t firebase messaging listener - notification title');
        message.notification!.body.prm('$t firebase messaging listener - notification body');
        // customSnackBar(
        //     context: context, title: "${message.notification!.title}\n${message.notification!.body}", durationSeconds: 3);
        AlertDialog alert = AlertDialog(
          title: Text(message.notification!.title ?? 'Notifcation Title'),
          content: Text(message.notification!.body ?? 'Notification Body'),
          actions: const [],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
    );
  }

  static Future<void> getToken() async {
    const t = 'getToken - FirebaseHelper';
    String? token = await FirebaseMessaging.instance.getToken();
    token.prm(t);
  }
}
