import 'dart:async';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/views/components/rootWidget.dart';
import 'package:app_leohis/views/screens/auth/screen_Login.dart';
import 'package:app_leohis/views/screens/splash/progress_dot.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreenLoader extends StatefulWidget {
  const SplashScreenLoader({Key? key}) : super(key: key);

  @override
  State<SplashScreenLoader> createState() => _SplashScreenLoaderState();
}

class _SplashScreenLoaderState extends State<SplashScreenLoader> {
  @override
  void initState() {
    super.initState();
    continueLogin();
  }

  LocalData _localData = LocalData();
  String tdn = '';
  continueLogin() async {
    tdn = await _localData.Shared_getTenNguoidung();
    setState(() {
      tdn;
    });
    if (tdn != '') {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NavBars()));
      });
    }
  }

  finish() {
    // Navigator.of(context).pop();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  late AnimationController lottieController;
  TextStyle style = TextStyle(
    fontSize: 25.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.w500,
  );
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [
        //         Colors.black,
        //         Colors.black87,
        //       ]),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 16.0 * 2),
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        Icon(FontAwesomeIcons.userDoctor,
                            size: 80, color: primaryColor),
                        SizedBox(height: 70),
                      ],
                    ),
                    themeProvider.isDarkMode || themeProvider.isSysDark(context)
                        ? Lottie.asset(
                            "assets/images/DarkHeart.json",
                            height: 300,
                            repeat: false,
                            delegates: LottieDelegates(
                              values: [
                                ValueDelegate.color(
                                  // keyPath order: ['layer name', 'group name', 'shape name']
                                  const ['**', 'wave_2 Outlines', '**'],
                                  value: Colors.orange,
                                ),
                              ],
                            ),
                          )
                        : Lottie.asset(
                            "assets/images/LightHeart.json",
                            height: 300,
                            repeat: false,
                            delegates: LottieDelegates(
                              values: [
                                ValueDelegate.colorFilter(
                                  ['LightHeart', '**'],
                                  value: ColorFilter.mode(
                                      Colors.blue, BlendMode.hardLight),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      tdn == ''
                          ? AnimatedTextKit(
                              totalRepeatCount: 1,
                              onFinished: () => finish(),
                              animatedTexts: [
                                RotateAnimatedText('Chào mừng bạn đến',
                                    textStyle: style),
                                RotateAnimatedText('Leohis App',
                                    textStyle: TextStyle(
                                        color: primaryColor,
                                        fontSize: 25,
                                        letterSpacing: 5.0,
                                        fontWeight: FontWeight.w900)),
                                RotateAnimatedText('Ứng dụng dành cho bác sĩ',
                                    textStyle: style),
                              ],
                            )
                          : Text(
                              "Leohis App",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 25,
                                  letterSpacing: 5.0,
                                  fontWeight: FontWeight.w900),
                            ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0 * 2),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 105,
                    height: 100,
                    alignment: Alignment.center,
                    child: WidgetDotBounce(
                        color: primaryColor,
                        size: 30.0), // Using a custom widget
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0 * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/image001_monochrome.png",
                      height: 70,
                      //width: 300.0,
                    ),
                    Opacity(
                      opacity: .4,
                      child: ImageIcon(
                        AssetImage("assets/image001.png"),
                        color: primaryColor,
                        size: 70,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leopard Solutions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Design",
                      style: TextStyle(color: Colors.grey, letterSpacing: 1.5),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
