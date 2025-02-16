import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_apps/common/local_notification.dart';
import 'package:tracking_apps/common/shared_preferance_service.dart';
import 'package:tracking_apps/configs/route/route_manager.dart';
import 'package:tracking_apps/presentation/blocs/custom_multi_bloc_provider.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );

  await initializeLocalNotifications();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a foreground message: ${message.notification?.title}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: 'Default_Sound',
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked!');
  });

  String? userRole = await SharedPreferencesService.instance
      .getData<String>(PreferenceKey.userRole);
  runApp(
    CustomMultiBlocProvider(
      child: MyApp(
        userRole: userRole,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? userRole;

  const MyApp({super.key, this.userRole});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [Locale('en', ''), Locale('id', '')],
        title: 'Dahana Tracking',
        routerConfig: RouterManager.router(userRole: userRole),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white, fontFamily: 'Satoshi'),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1)),
            child: widget!,
          );
        },
      ),
    );
  }
}
