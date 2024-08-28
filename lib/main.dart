import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Controller/ListProvider.dart';
import 'package:palnt_app/Controller/Provier.dart';
import 'package:palnt_app/Services/NotifactionServices.dart';
import 'package:palnt_app/View/MyCollection/Controller/MyCollectionController.dart';
import 'package:palnt_app/View/Splash/View/Splash.dart';
import 'package:palnt_app/firebase_options.dart';
import 'package:palnt_app/l10n/app_localizations.dart';
import 'package:palnt_app/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'View/Splash/Controller/SplashController.dart';
import 'package:timezone/data/latest_all.dart' as tz;

NotificationServices notificationServices = NotificationServices();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

  runApp(
    MultiProvider(
      providers: listproviders,
      child: MyApp(),
    ),
  );
}

alarmprovider AlarmProvider = alarmprovider();
MyCollectionController collectionController = MyCollectionController();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<alarmprovider>().Inituilize(context);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
    context.read<alarmprovider>().GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeBloom',
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: kBaseColor,
        scaffoldBackgroundColor: kBaseColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kSecendryColor),
          ),
        ),
        iconTheme: IconThemeData(
          color: kSecendryColor,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: kSecendryColor,
        ),
        useMaterial3: false,
        colorScheme: ColorScheme.light(
          primary: kSecendryColor,
          secondary: kSecendryColor,
        ).copyWith(background: kBaseColor),
      ),
      locale: Locale('ar'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: ChangeNotifierProvider<SplashController>(
        create: (context) => SplashController()..whenIslogin(context),
        builder: (context, child) => Splash(),
      ),
      builder: (context, child) {
        EasyLoading.instance
          ..displayDuration = const Duration(seconds: 3)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 15.0
          ..maskType = EasyLoadingMaskType.black
          ..progressColor = kSecendryColor
          ..backgroundColor = kBaseColor
          ..indicatorColor = kSecendryColor
          ..textColor = kSecendryColor
          ..maskColor = Colors.black
          ..userInteractions = false
          ..animationStyle = EasyLoadingAnimationStyle.opacity
          ..dismissOnTap = false;
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
