import 'package:app_leohis/views/components/rootWidget.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingDialog extends StatefulWidget {
  const SettingDialog({super.key});

  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  int _selectedIndex = 0;

  int _themeMode = 0;
  int _tmp = 0;
  void readTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? indexTheme = await prefs.getInt('theme');
    int? indexMode = await prefs.getInt('themeMode');
    setState(() {
      _selectedIndex = indexTheme ?? 0;
      _themeMode = indexMode ?? 0;
      _tmp = _selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    readTheme();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    List<Color> listColors = provider.isDarkMode || provider.isSysDark(context)
        ? darkThemes
        : lightThemes;

    return Center(
      child: AlertDialog(
        shadowColor: Colors.black26,
        elevation: 10,
        // buttonPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(Icons.settings),
            Text(" Cài đặt", style: TextStyle()),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            // constraints: BoxConstraints(minHeight: 200),
            width: screen(context).width / 1.2,
            // constraints: BoxConstraints(maxWidth: 400),
            // height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    children: [
                      DividerTitle(title: "Chủ đề"),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 40,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              for (int index = 0;
                                  index < listColors.length;
                                  index++)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                    provider.toggleColor(index, context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: listColors[index],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: _selectedIndex == index
                                        ? Icon(Icons.check_circle,
                                            size: 20,
                                            color: Theme.of(context).cardColor)
                                        : null,
                                  ),
                                ),
                            ]),
                      ),
                      Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        // elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Icon(Icons.person,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(.5)),
                            ),
                            title: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height: 10,
                              width: 50,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  height: 10,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: primaryColor.withOpacity(.15)),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 3),
                                  height: 10,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: listColors[_selectedIndex]
                                          .withOpacity(.15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      DividerTitle(title: "Giao diện"),
                      RadioListTile(
                        activeColor: primaryColor,
                        title: Row(
                          children: [
                            Text("Hệ thống   "),
                            Icon(Icons.phone_android, color: primaryColor)
                          ],
                        ),
                        value: 0,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                      RadioListTile(
                        activeColor: primaryColor,
                        title: Row(
                          children: [
                            Text("Nền sáng  "),
                            Icon(Icons.brightness_7, color: primaryColor)
                          ],
                        ),
                        value: 1,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                      RadioListTile(
                        activeColor: primaryColor,
                        title: Row(
                          children: [
                            Text("Nền tối      "),
                            Icon(Icons.brightness_4_outlined,
                                color: primaryColor)
                          ],
                        ),
                        value: 2,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          setState(() {
                            _themeMode = value!;
                          });
                          provider.toggleTheme(value!, _selectedIndex, context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("Ok", style: TextStyle(color: primaryColor)),
            onPressed: () {
              if (_tmp != _selectedIndex) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavBars(),
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
