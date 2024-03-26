import 'package:app_leohis/models/HienDien.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingCard.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unicons/unicons.dart';
import 'package:countup/countup.dart';

// ignore: must_be_immutable
class ThongKe_Container extends StatefulWidget {
  HienDienData thongKeData;
  List<ChartData> datachart;
  List<ChartData> chart;
  ThongKe_Container({
    super.key,
    required this.thongKeData,
    required this.chart,
    required this.datachart,
  });

  @override
  State<ThongKe_Container> createState() => _ThongKe_ContainerState();
}

class _ThongKe_ContainerState extends State<ThongKe_Container> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 420,
          child: Column(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: primaryColor,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 200,
                        width: 150,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hiện diện",
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 110,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            UniconsLine.chart_pie_alt,
                                            size: 30,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                          SizedBox(width: 5),
                                          Countup(
                                            begin: 0,
                                            end:
                                                widget.thongKeData.hiendien / 1,
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).canvasColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "Tổng hiện diện",
                                      style: TextStyle(
                                          color: Theme.of(context).canvasColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        UniconsLine.mars,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      Text(
                                        "  Nam:  ${widget.thongKeData.nam}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        UniconsLine.venus,
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      Text(
                                        "  Nữ:     ${widget.thongKeData.nu}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            enableSideBySideSeriesPlacement: false,
                            series: <ChartSeries<ChartData, dynamic>>[
                              ColumnSeries<ChartData, dynamic>(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  dataSource: widget.chart,
                                  xValueMapper: (datum, index) =>
                                      datum.loai.toString(),
                                  yValueMapper: (datum, index) =>
                                      datum.soLuong.toInt(),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        primaryColor.withOpacity(.5),
                                        primaryColor
                                      ]),
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true),
                                  width: 0.8,
                                  spacing: 0.2)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: widget.datachart.isEmpty
                              ? [
                                  LoadingCard(),
                                  LoadingCard(),
                                  LoadingCard(),
                                  LoadingCard(),
                                ]
                              : [
                                  for (int index = 0;
                                      index < widget.datachart.length / 2;
                                      index++)
                                    Card(
                                      elevation: .7,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                color: colorsList[index],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            Text(widget.datachart[index].loai),
                                            Expanded(
                                                child: Countup(
                                              begin: 0,
                                              end: widget.datachart[index]
                                                      .soLuong /
                                                  1,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: widget.datachart.isEmpty
                              ? [
                                  LoadingCard(),
                                  LoadingCard(),
                                  LoadingCard(),
                                  LoadingCard(),
                                ]
                              : [
                                  for (int index = int.parse(
                                          (widget.datachart.length / 2)
                                              .toStringAsFixed(0));
                                      index < widget.datachart.length;
                                      index++)
                                    Card(
                                      elevation: .7,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                color: colorsList[index],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            Text(widget.datachart[index].loai),
                                            Expanded(
                                                child: Countup(
                                              begin: 0,
                                              end: widget.datachart[index]
                                                      .soLuong /
                                                  1,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.loai, this.soLuong);
  final String loai;
  final int soLuong;
}
