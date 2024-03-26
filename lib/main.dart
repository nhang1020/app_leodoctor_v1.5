import 'package:app_leohis/firebase/firebase_options.dart';
import 'package:app_leohis/models/LocalAccount.dart';
import 'package:app_leohis/views/components/notification_manager/firebase_notification.dart';
import 'package:app_leohis/views/screens/noInternetScreen.dart';
import 'package:app_leohis/views/screens/splash/splash_screen_loader.dart';
import 'package:app_leohis/views/utils/provider.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_leohis/views/utils/contants.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var connectivityResult = await (Connectivity().checkConnectivity());
  bool connect = false;
  print(connectivityResult);
  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile) {
    connect = true;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessageApi().initNotification();
    await FirebaseMessaging.instance.subscribeToTopic("ALL");
  }

  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final indexTheme = prefs.getInt('themeMode') ?? 0;
  int indexColor = prefs.getInt('theme') ?? 0;

  print('connect: $connect');
  runApp(
    connect
        ? ChangeNotifierProvider(
            create: (context) => KhoaProvider(),
            child: MyApp(indexTheme: indexTheme, indexColor: indexColor),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: NoInternetScreen(),
          ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.indexTheme, required this.indexColor});
  final indexTheme;
  final indexColor;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    Provider.of<KhoaProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(indexTheme, indexColor),
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        themeProvider.toggleColor(themeProvider.indexCl, context);

        return MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('vi', 'VN'),
            // Locale('en', 'US'),
          ],
          title: 'LeoHospital',
          darkTheme: ThemeData(
            bannerTheme: MaterialBannerThemeData(
                shadowColor: Colors.black87, elevation: 10),
            chipTheme: ChipThemeData(backgroundColor: Colors.transparent),
            primaryColorDark: primaryColor,
            brightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: Color(0xff20242A),
              headerForegroundColor: primaryColor,
            ),
            cardColor: Color(0xff2B3038),
            canvasColor: Color(0xff20242A),
            cardTheme: CardTheme(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            colorScheme: ColorScheme.dark(
              primary: primaryColor,
            ),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xff2B3038)),
            textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.white70),
              bodyLarge: TextStyle(color: Colors.white),
              labelLarge: TextStyle(color: primaryColor),
            ),
            dialogTheme: DialogTheme(
              backgroundColor: Color(0xff2B3038),
              // elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dividerColor: Colors.white,
          ),
          //
          //
          theme: ThemeData(
            bannerTheme: MaterialBannerThemeData(
                shadowColor: primaryColor.withOpacity(.5), elevation: 10),
            chipTheme: ChipThemeData(backgroundColor: Colors.transparent),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            cardTheme: CardTheme(
                elevation: 5,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
              // bodyLarge: TextStyle(color: primaryColor),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
            canvasColor: const Color.fromARGB(255, 247, 247, 247),
            cardColor: Colors.white,
            datePickerTheme:
                DatePickerThemeData(headerBackgroundColor: primaryColor),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: SplashScreenLoader()),
        );
      },
    );
  }
}
