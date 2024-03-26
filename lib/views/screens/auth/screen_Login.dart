import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/LoginController.dart';
import 'package:app_leohis/models/LocalAccount.dart';
import 'package:app_leohis/models/taiKhoan.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/curveBackground.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/components/rootWidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:unicons/unicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      showMessage(context,
          message: "Đăng nhập thành công",
          type: "success",
          position: StyledToastPosition.top);
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

      showMessage(
        context,
        message: "Tên đăng nhập hoặc mật khẩu không đúng",
        type: "error",
      );
    }
    if (result == 2) {
      Navigator.pop(context);
      showMessage(context,
          message: "Lỗi kết nôi",
          type: "error",
          position: StyledToastPosition.bottom);
    }
  }

  continueLogin() async {
    Account? account = await _localData.Hive_getLocalAccount();
    if (account != null) {
      _conTenDangNhap.text = account.UsernName;
      _conMatKhau.text = account.Password;
    }
    // if (await _logincontroller.continueLogin() == true) {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (_) => NavBars()));
    //   // loadingDialog();
    // }
  }

  @override
  void initState() {
    super.initState();
    loading = false;

    continueLogin();
    getTheme();
  }

  void _showWhiteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Đặt màu nền của dialog là trắng
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
    borderRadius: BorderRadius.circular(15), // Đặt border radius tại đây
    borderSide: BorderSide(
      color: Colors.transparent, // Đặt màu viền trong suốt tại đây
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screen(context).height,
          constraints: BoxConstraints(minHeight: 700),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                children: [
                  Container(
                    height: screen(context).height / 2,
                    constraints: BoxConstraints(minHeight: 350),
                    width: screen(context).width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/healthcare-background-ur9es9e3f2t9gfkd.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Container(
                    height: screen(context).height / 2,
                    constraints: BoxConstraints(minHeight: 350),
                    width: screen(context).width,
                    color: primaryColor.withOpacity(.7),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(flex: 3, child: Container()),
                  Expanded(
                    flex: 3,
                    child: ClipPath(
                      clipper: CurveClipper(),
                      child: Scaffold(
                        body: Container(
                          // height: screen(context).height / 2,
                          constraints: BoxConstraints(minHeight: 400),
                          width: screen(context).width,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: screen(context).height / 6,
                      constraints: BoxConstraints(maxHeight: 140),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 6,
                      child: CustomPaint(
                        painter: DrawOval(),
                        child: Container(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              width: screen(context).width,
                              constraints: BoxConstraints(maxWidth: 400),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 50),
                                  Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/bgtitle.png"),
                                        fit: BoxFit.fill,
                                        opacity: .3,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "Xin chào,",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        "Leohis Doctor App",
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 100),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    isUsernameNull ? 10 : 0),
                                            child: TextFormField(
                                              controller: _conTenDangNhap,
                                              decoration: InputDecoration(
                                                labelText: 'Tên đăng nhập',
                                                hintText: 'Tên đăng nhập',
                                                prefixIcon: Icon(
                                                  UniconsLine.user,
                                                  color: Colors.grey,
                                                ),
                                                border: outlineInputBorder,
                                                enabledBorder:
                                                    outlineInputBorder,
                                                focusedBorder:
                                                    outlineInputBorder,
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                        ),
                                        SizedBox(height: 20),
                                        Card(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    isPasswordNull ? 10 : 0),
                                            child: TextFormField(
                                              controller: _conMatKhau,
                                              obscureText: !_isPasswordVisible,
                                              decoration: InputDecoration(
                                                  labelText: 'Mật khẩu',
                                                  hintText: 'Mật khẩu',
                                                  prefixIcon: Icon(
                                                    UniconsLine.lock,
                                                    color: Colors.grey,
                                                  ),
                                                  border: outlineInputBorder,
                                                  enabledBorder:
                                                      outlineInputBorder,
                                                  focusedBorder:
                                                      outlineInputBorder,
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      !_isPasswordVisible
                                                          ? Icons
                                                              .visibility_off_outlined
                                                          : Icons
                                                              .visibility_off_outlined,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isPasswordVisible =
                                                            !_isPasswordVisible;
                                                      });
                                                    },
                                                  )),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Switch(
                                            activeColor: primaryColor,
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
                                              color: _rememberMe
                                                  ? primaryColor
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      MyButton(
                                        width: 140,
                                        label: "Đăng nhập",
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            login();
                                            if (loading) {
                                              _showWhiteDialog(context);
                                            }
                                          }
                                        },
                                        color: primaryColor,
                                        radius: 20,
                                        height: 40,
                                      ),
                                      SizedBox(width: 10),
                                      MyButton(
                                        onPressed: () {},
                                        label: "Trợ giúp?",
                                        color: Colors.transparent,
                                        textColor: Colors.grey,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            )),
                            child: Container(
                              height: 50,
                              width: screen(context).width / 1.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Design by Leopard Solutions",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(width: 5),
                                  Stack(
                                    children: [
                                      Image.asset(
                                        "assets/image001_monochrome.png",
                                        height: 25,
                                        //width: 300.0,
                                      ),
                                      Opacity(
                                        opacity: .4,
                                        child: ImageIcon(
                                          AssetImage("assets/image001.png"),
                                          color: primaryColor,
                                          size: 25,
                                        ),
                                      ),
                                    ],
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class DrawOval extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(
        Offset(size.width, size.height / 8), size.width / 6, paint);

    canvas.drawCircle(Offset(0, size.height * 6 / 7.8), size.width / 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
