import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LichTruc_Container extends StatefulWidget {
  const LichTruc_Container({
    super.key,
    required this.lstBacSi,
    required this.lstDieuDuong,
    required this.lstHoLy,
  });
  final List<String> lstBacSi;
  final List<String> lstDieuDuong;
  final List<String> lstHoLy;
  @override
  State<LichTruc_Container> createState() => _LichTruc_ContainerState();
}

class _LichTruc_ContainerState extends State<LichTruc_Container> {
  PageController _pageController = PageController(initialPage: 0);

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [
      Card(
        child: widget.lstBacSi.length == 0
            ? EmptyList()
            : ListView(
                physics: BouncingScrollPhysics(),
                primary: false,
                children: widget.lstBacSi
                    .map(
                      (e) => ListItem(item: e, type: 0),
                    )
                    .toList()),
      ),
      Card(
        child: widget.lstDieuDuong.length == 0
            ? EmptyList()
            : ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                primary: false,
                children: widget.lstDieuDuong
                    .map(
                      (e) => ListItem(item: e, type: 1),
                    )
                    .toList()),
      ),
      Card(
        child: widget.lstHoLy.length == 0
            ? EmptyList()
            : ListView(
                physics: BouncingScrollPhysics(),
                primary: false,
                children: widget.lstHoLy
                    .map(
                      (e) => ListItem(item: e, type: 2),
                    )
                    .toList()),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: .7,
                      child: Container(
                        width: 10,
                        child: Icon(Icons.circle, color: primaryColor),
                      ),
                    ),
                    Opacity(
                      opacity: .4,
                      child: Container(
                        alignment: Alignment.centerRight,
                        width: 35,
                        child: Icon(Icons.circle, color: primaryColor),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                formatDateVi(DateTime.now()),
                style: GoogleFonts.comfortaa(
                    textStyle: TextStyle(
                  letterSpacing: 1,
                  color: primaryColor.withOpacity(.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                )),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Card(
                elevation: .5,
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        width: 250,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Badge(
                                offset: Offset(-5, -5),
                                label: Countup(
                                    begin: 0,
                                    end: widget.lstBacSi.length / 1,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                backgroundColor: Theme.of(context).canvasColor,
                                child: MyButton(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(15)),
                                  duration: Duration(milliseconds: 300),
                                  label: "Bác sĩ",
                                  onPressed: () {
                                    _pageController.animateToPage(0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.bounceIn);
                                  },
                                  color: _selectedIndex == 0
                                      ? null
                                      : Colors.transparent,
                                  textColor: _selectedIndex == 0
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Badge(
                                offset: Offset(-5, -5),
                                label: Countup(
                                    begin: 0,
                                    end: widget.lstDieuDuong.length / 1,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                backgroundColor: Theme.of(context).canvasColor,
                                child: MyButton(
                                  duration: Duration(milliseconds: 300),
                                  label: "Điều dưỡng",
                                  padding: EdgeInsets.zero,
                                  radius: 0,
                                  onPressed: () {
                                    _pageController.animateToPage(1,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  color: _selectedIndex == 1
                                      ? null
                                      : Colors.transparent,
                                  textColor: _selectedIndex == 1
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Badge(
                                offset: Offset(-5, -5),
                                label: Countup(
                                    begin: 0,
                                    end: widget.lstHoLy.length / 1,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                backgroundColor: Theme.of(context).canvasColor,
                                child: MyButton(
                                  duration: Duration(milliseconds: 300),
                                  label: "Hộ lý",
                                  onPressed: () {
                                    _pageController.animateToPage(2,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.bounceIn);
                                  },
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(15)),
                                  color: _selectedIndex == 2
                                      ? null
                                      : Colors.transparent,
                                  textColor: _selectedIndex == 2
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 15),
                        color: Theme.of(context)
                            .bannerTheme
                            .shadowColor!
                            .withOpacity(.5),
                        blurRadius: 20,
                      )
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).cardColor,
                    ),
                    Text(
                      "Lịch trực",
                      style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            padding: EdgeInsets.only(top: 20),
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              children: _widgets,
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.item, required this.type});

  final String item;
  final int type;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .7,
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Image.asset(
            type == 0
                ? "assets/images/icons/stethoscope_96px.png"
                : (type == 1
                    ? "assets/images/icons/nurse_96px.png"
                    : "assets/images/icons/robbery_96px.png"),
            width: 30,
            color: primaryColor,
          ),
        ),
        title: Text(item),
        trailing: Icon(Icons.circle, size: 10, color: Colors.greenAccent),
      ),
    );
  }
}
