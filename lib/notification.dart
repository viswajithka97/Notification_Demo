import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  if (message.data.containsKey("data")) {
    final data = message.data["data"];
  }
  if (message.data.containsKey("notification")) {
    final notification = message.data["notification"];
  }
}

class FCM {
  final streamCtrl = StreamController<String>.broadcast();
  final tittleCtrl = StreamController<String>.broadcast();
  final bodyCtrl = StreamController<String>.broadcast();

  setNotification() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    foregroundNotification();
    backGroundNotification();
    terminateNotification();
  }

  foregroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.containsKey("data")) {
        streamCtrl.sink.add(message.data["data"]);
      }
      if (message.data.containsKey("notification")) {
        streamCtrl.sink.add(message.data["notification"]);
      }
      tittleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  backGroundNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.containsKey("data")) {
        streamCtrl.sink.add(message.data["data"]);
      }
      if (message.data.containsKey("notification")) {
        streamCtrl.sink.add(message.data["notification"]);
      }
      tittleCtrl.sink.add(message.notification!.title!);
      bodyCtrl.sink.add(message.notification!.body!);
    });
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.containsKey("data")) {
        streamCtrl.sink.add(initialMessage.data["data"]);
      }
      if (initialMessage.data.containsKey("notification")) {
        streamCtrl.sink.add(initialMessage.data["notification"]);
      }
      tittleCtrl.sink.add(initialMessage.notification!.title!);
      bodyCtrl.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose() {
    streamCtrl.close();
    tittleCtrl.close();
    bodyCtrl.close();
  }
}
