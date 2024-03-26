import 'dart:ui';

import 'package:app_leohis/controllers/LoginController.dart';
import 'package:app_leohis/models/LocalAccount.dart';
import 'package:app_leohis/models/taiKhoan.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
// import 'package:app_leohis/views/icons/my_flutter_app_icons.dart';
import 'package:app_leohis/views/components/snackbarNotifications.dart';
import 'package:app_leohis/views/components/rootWidget.dart';
import 'package:app_leohis/views/icons/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/LocalData.dart';

class LoginSrceen extends StatefulWidget {
  const LoginSrceen({Key? key}) : super(key: key);

  @override
  State<LoginSrceen> createState() => _LoginSrceenState();
}

class _LoginSrceenState extends State<LoginSrceen> {
  //Color color = Color(0xFF2185D0);
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = screen(context).width < 800;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 241, 241),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: screen(context).height / 2,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: RotatedBox(
                quarterTurns: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Design by Leopard Solutions"),
                    SizedBox(width: 10),
                    Icon(MyFlutterApp.logo, color: primaryColor),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  // color: themeModeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: isSmallScreen
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    height: screen(context).height / 2,
                                    child: _FormContent()),
                                _Logo(),
                              ],
                            )
                          : Container(
                              padding: const EdgeInsets.all(15.0),
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: SingleChildScrollView(
                                        child: _FormContent()),
                                  ),
                                  Expanded(child: _Logo()),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: themeModeColor,
      ),
      height: screen(context).height / 2,
      width: screen(context).width,
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 41, 66),
              borderRadius: BorderRadius.vertical(
                top: Radius.elliptical(50, 30),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 300,
                  child: ListTile(
                    title: Text(
                      "Xin chào,",
                      style: TextStyle(
                        color: themeModeColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Chào mừng bạn đến Leohis App",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Icon(
                  MyFlutterApp.logo,
                  color: primaryColor,
                  size: 100,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            height: 350,
            child: Container(
              height: 250,
              width: 250,
              child: Lottie.asset("assets/images/Research.json"),
            ),
          ),
          Container(
            height: screen(context).height / 2,
            child: Column(
                // children: [Text("Tôi chưa ")],
                ),
          )
        ],
      ),
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  LoginController _logincontroller = LoginController();
  LocalData _localData = LocalData();
  //
  bool _isPasswordVisible = false;
  bool _rememberMe = true;
  bool isPasswordNull = false;
  bool isUsernameNull = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _conTenDangNhap = TextEditingController();
  final _conMatKhau = TextEditingController();
  bool loading = false;

  saveAccount() async {
    // save Hive
    LocalData localData = LocalData();
    localData.Hive_saveLocalAccount(
        _conTenDangNhap.text, _conMatKhau.text, _rememberMe);

    // save Shared
    DataAccount? account = await _logincontroller.getDataAccount(
        _conTenDangNhap.text, _conMatKhau.text);
    localData.Shared_saveLocalDataAccount(account);
  }

  login() async {
    setState(() {
      loading = true;
    });
    int result = await _logincontroller.login(
        _conTenDangNhap.text, _conMatKhau.text, _rememberMe);
    if (result == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        MyNotifications().successSnackBar('Đăng nhập thành công'),
      );
      // Không ghi nhớ đăng nhập
      if (_rememberMe == false) {
        _localData.Hive_clearAccount();
      }
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => NavBars()));
    }

    if (result == 1) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        MyNotifications()
            .errorSnackBar("Tên đăng nhập hoặc mật khẩu không chính xác."),
      );
    }
    if (result == 2) {
      Navigator.pop(context);
      showMessage(context, message: "Lỗi kết nối", type: "error");
    }
  }

  continueLogin() async {
    Account? account = await _localData.Hive_getLocalAccount();
    if (account != null) {
      _conTenDangNhap.text = account.UsernName;
      _conMatKhau.text = account.Password;
    }
    if (await _logincontroller.continueLogin() == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => NavBars()));
      // loadingDialog();
    }
  }

  @override
  void initState() {
    loading = false;
    continueLogin();

    super.initState();
  }

  void _showWhiteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: themeModeColor, // Đặt màu nền của dialog là trắng
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Đang đăng nhập..."),
              ],
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0), // Đặt border radius tại đây
    borderSide: BorderSide(
      color: Colors.transparent, // Đặt màu viền trong suốt tại đây
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 70),
        height: screen(context).height / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: themeModeColor,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(bottom: isUsernameNull ? 10 : 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 3),
                      blurRadius: 7,
                      color: Color.fromARGB(255, 228, 228, 228),
                    )
                  ],
                  color: themeModeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _conTenDangNhap,
                  decoration: InputDecoration(
                    fillColor: themeModeColor,
                    filled: true,
                    labelText: 'Tên đăng nhập',
                    hintText: 'Tên đăng nhập',
                    prefixIcon: Icon(
                      UniconsLine.user,
                      color: Colors.black38,
                    ),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        isUsernameNull = true;
                      });
                      return 'Tên đăng nhập trống';
                    }
                    setState(() {
                      isUsernameNull = false;
                    });
                    return null;
                  },
                ),
              ),
              _gap(),
              Container(
                padding: EdgeInsets.only(bottom: isPasswordNull ? 10 : 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 3),
                      blurRadius: 7,
                      color: Color.fromARGB(255, 228, 228, 228),
                    )
                  ],
                  color: themeModeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _conMatKhau,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                      fillColor: themeModeColor,
                      filled: true,
                      labelText: 'Mật khẩu',
                      hintText: 'Mật khẩu',
                      prefixIcon: const Icon(
                        UniconsLine.lock,
                        color: Colors.black38,
                      ),
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !_isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.black38,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        isPasswordNull = true;
                      });
                      return 'Vui lòng nhập mật khẩu';
                    }
                    setState(() {
                      isPasswordNull = false;
                    });
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    children: [
                      Switch(
                        value: _rememberMe,
                        onChanged: (value) {
                          // ignore: unnecessary_null_comparison
                          if (value == null) return;
                          setState(() {
                            _rememberMe = value;
                          });
                        },
                      ),
                      Text(
                        "Ghi nhớ đăng nhập",
                        style: TextStyle(
                          color: _rememberMe ? primaryColor : Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              MyButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    login();
                    if (loading) {
                      _showWhiteDialog(context);
                    }
                  }
                },
                padding: EdgeInsets.all(10),
                label: "ĐĂNG NHẬP",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
