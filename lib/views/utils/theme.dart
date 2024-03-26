import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// List<ThemeMode> listMode = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(int indexTheme, int indexColor) {
    if (indexTheme == 0) {
      themeMode = ThemeMode.system;
    } else if (indexTheme == 1) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    indexCl = indexColor;
    primaryColor =
        isDarkMode ? darkThemes[indexColor] : lightThemes[indexColor];
  }
  ThemeMode themeMode = ThemeMode.light;

  // Future<int> getIndexThemeMode() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('themeMode') ?? 0;
  // }
  int indexCl = 0;
  bool isSysDark(BuildContext context) =>
      themeMode == ThemeMode.system &&
      MediaQuery.of(context).platformBrightness == Brightness.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  toggleColor(int index, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('theme', index);
    indexCl = index;
    primaryColor = isDarkMode || isSysDark(context)
        ? darkThemes[index]
        : lightThemes[index];

    notifyListeners();
  }

  toggleTheme(int mode, int index, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mode == 0) {
      themeMode = ThemeMode.system;
    } else if (mode == 1) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    prefs.setInt('themeMode', mode);
    primaryColor = isDarkMode || isSysDark(context)
        ? darkThemes[index]
        : lightThemes[index];
    notifyListeners();
  }
}

class ThemeClass {
  static ThemeData darkTheme = ThemeData(
    primaryColorDark: primaryColor,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    datePickerTheme: DatePickerThemeData(headerBackgroundColor: primaryColor),
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
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  //
  static ThemeData lightThemes = ThemeData(
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    cardTheme: CardTheme(
        elevation: 5,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      // bodyLarge: TextStyle(color: primaryColor),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
    cardColor: Colors.white,
    datePickerTheme: DatePickerThemeData(headerBackgroundColor: primaryColor),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );
}

ThemeClass themeClass = ThemeClass();

TimePickerThemeData timePickerThemeData(BuildContext context) =>
    TimePickerThemeData(
      dialHandColor: primaryColor,
      backgroundColor: Theme.of(context).canvasColor,
      hourMinuteColor: primaryColor.withOpacity(0.1),
      // hourMinuteTextColor: Colors.blueGrey.shade500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      confirmButtonStyle: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
          backgroundColor: MaterialStatePropertyAll(primaryColor)),
      helpTextStyle: TextStyle(fontSize: 15),

      hourMinuteShape:
          BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
      dialTextStyle: TextStyle(fontSize: 14),
    );
