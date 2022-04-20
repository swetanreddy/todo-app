import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/auth/authenticate.dart';
import 'package:todo/helpers/theme.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? localToken = " ";

  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }

  // void sendPushMessage() async {
  //   try {
  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'key=AAAA9xPglTQ:APA91bEuI1Hg2Mw6dLpBuh2bDvJfgcYOUm_rEUhq3glaPRzICYtTUQEG6iFF1r_EeWx3B_wC9sTDVxk0x1PYgcSh-N9Di4qG-GNF3LVDjhc9F5B_cfEqvdky-Rc1ILwdAc1oqtB5Ho8v',
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'notification': <String, dynamic>{
  //             'body': 'Test Body',
  //             'title': 'Test Title 2'
  //           },
  //           'priority': 'high',
  //           'data': <String, dynamic>{
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'id': '1',
  //             'status': 'done'
  //           },
  //           "to": "$token",
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     print("error push notification");
  //   }
  // }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            localToken = token;
          });
        }
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Image(
                  height: 400,
                  width: 500,
                  image: AssetImage(
                    'assets/images/splash.png',
                  ),
                ),
              ),
              const Image(
                height: 200,
                width: 500,
                image: AssetImage(
                  'assets/images/splashtext.png',
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    getToken();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => Authenticate()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 0, right: 5),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: const BorderRadius.all(Radius.circular(15))),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
