import 'package:app_leohis/controllers/FCMController.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Screen_LichHen extends StatefulWidget {
  const Screen_LichHen({super.key});

  @override
  State<Screen_LichHen> createState() => _Screen_LichHenState();
}

class _Screen_LichHenState extends State<Screen_LichHen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  int selectedIndex = -1;

  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _selectedTime = TimeOfDay.now();
          });
          _eventController.text = '';
          _descriptionController.text = '';
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).canvasColor,
              contentPadding: EdgeInsets.zero,
              title: Text("Thêm sự kiện"),
              scrollable: true,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  TimePicker(
                    onTimeSelected: (value) {
                      setState(() {
                        _selectedTime = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: InputBorder.none,
                          hintText: "Tên sự kiện",
                        ),
                        controller: _eventController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Mô tả",
                            border: InputBorder.none),
                        controller: _descriptionController,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final selectedDate = _selectedDay!;
                    if (events[selectedDate] == null) {
                      events[selectedDate] = [];
                    }
                    events[selectedDate]!.add(Event(_selectedTime,
                        _eventController.text, _descriptionController.text));
                    Navigator.of(context).pop();
                    setState(() {
                      _selectedEvents.value = _getEventsForDay(_selectedDay!);
                    });
                    FCMController.sendNotification(
                        receiverToken:
                            "d1_VWNvuRkeBk-V5sXj8GU:APA91bEAQjKlgGXJWFah_Mz4g8pmekDwBs-JWOiiEo9ShFnxr-LeyRsr4COZD-Sa4iWikROH35jKe1ATAXoBv6ao5sODcinkTJMVPuDPxwQESb_udYnZgwGhf1zotMgzqZbsRrHFgicu",
                        body:
                            "Bạn đã đăng ký lịch khám thành công\n thời gian khám lịch là: ${formatDateVi2(_selectedDay)} \n vào lúc ${formatTimeOfDay(_selectedTime)}",
                        title: "Thông báo");
                  },
                  child: Text("Thêm"),
                ),
              ],
            ),
          );
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
      body: Container(
        height: screen(context).height,
        padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(.7),
            primaryColor.withOpacity(.7),
            primaryColor,
            primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Stack(
          children: [
            Container(
              height: 459,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: 449,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  child: Container(
                    height: 435,
                    child: TableCalendar(
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (BuildContext context, date, events) {
                          if (events.isEmpty) return SizedBox();
                          print("object");
                          return Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.bottomCenter,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              // color:
                              //     colors[Random().nextInt(6)].withOpacity(.2),
                              shape: BoxShape.circle,
                            ),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    events.length > 4 ? 4 : events.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 31),
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                      // height: 7,
                                      width: 7,
                                      // margin: EdgeInsets.symmetric(horizontal: 1),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                      // locale: 'vi_VN',
                      firstDay: DateTime.now().subtract(Duration(days: 180)),
                      lastDay: DateTime.now().add(Duration(days: 180)),
                      availableGestures: AvailableGestures.all,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          decoration: BoxDecoration(),
                          weekendStyle: TextStyle(fontWeight: FontWeight.w600),
                          weekdayStyle: TextStyle()),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      eventLoader: _getEventsForDay,
                      //style
                      headerStyle: HeaderStyle(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [boxShadows[0]],
                        ),
                        formatButtonDecoration: BoxDecoration(
                          color: primaryColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        formatButtonTextStyle: TextStyle(color: Colors.white),
                        // formatButtonVisible: false,
                        titleCentered: true,
                        headerMargin: EdgeInsets.symmetric(vertical: 20),
                        titleTextFormatter: (date, locale) {
                          return 'Tháng ${date.month}, ${date.year}';
                        },
                        leftChevronIcon:
                            Icon(Icons.arrow_back_ios_new, color: primaryColor),
                        rightChevronIcon:
                            Icon(Icons.arrow_forward_ios, color: primaryColor),
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: primaryColor,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        // outsideDaysVisible: false,
                        outsideTextStyle:
                            TextStyle(color: Colors.grey.withOpacity(.5)),
                        defaultTextStyle:
                            TextStyle(fontWeight: FontWeight.w500),
                        weekendTextStyle:
                            TextStyle(fontWeight: FontWeight.w500),
                        selectedDecoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.white),
                        todayDecoration: BoxDecoration(
                            border:
                                Border.all(color: primaryColor.withOpacity(.3)),
                            shape: BoxShape.circle),
                        todayTextStyle: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            DraggableScrollableSheet(
              initialChildSize: 0.35,
              maxChildSize: 0.7,
              minChildSize: 0.35,
              builder: (context, scrollController) => Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -5),
                    blurRadius: 20,
                    color: Colors.black12,
                  )
                ]),
                child: Card(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 5,
                          margin: EdgeInsets.all(10),
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [Text("")],
                          ),
                        ),
                        Container(
                          height: 500,
                          child: _selectedEvents.value.isNotEmpty
                              ? ValueListenableBuilder<List<Event>>(
                                  valueListenable: _selectedEvents,
                                  builder: (context, value, child) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: ListView.builder(
                                        physics: ScrollPhysics(),
                                        itemCount: value.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 0,
                                            color:
                                                colorsCon[index > 3 ? 4 : index]
                                                    .withOpacity(.1),
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: ListTile(
                                              onTap: () {
                                                setState(() {
                                                  selectedIndex =
                                                      selectedIndex == index
                                                          ? -1
                                                          : index;
                                                });
                                              },
                                              leading: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 15),
                                                // height: 50,
                                                decoration: BoxDecoration(
                                                    color: colorsCon[index > 3
                                                            ? 4
                                                            : index]
                                                        .withAlpha(200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                    "${formatTimeOfDay(value[index].time)}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black54,
                                                    )),
                                              ),
                                              title:
                                                  Text("${value[index].title}"),
                                              subtitle: Text(
                                                "${value[index].description}",
                                                maxLines: selectedIndex == index
                                                    ? null
                                                    : 1,
                                              ),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      value
                                                          .remove(value[index]);
                                                    });
                                                  },
                                                  icon: Icon(Icons.check)),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Column(
                                  children: [
                                    Text(
                                      "${formatDate(_selectedDay!)}",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Chưa có lịch nào",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Opacity(
                                      opacity: .4,
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          "assets/images/empty-box.png",
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Map<DateTime, List<Event>> events = {};

class Event {
  final TimeOfDay time;
  final String title;
  final String description;
  Event(this.time, this.title, this.description);
}

List<Color> colors = [
  Colors.red.shade300,
  Color.fromARGB(255, 237, 222, 81),
  Colors.blue.shade400,
  Colors.green.shade300,
  Colors.purple.shade400,
  Colors.pink.shade300,
];

List<Color> colorsCon = [
  primaryColor,
  Colors.yellow,
  Colors.purple,
  Colors.blue,
  Colors.pink,
];

class TimePicker extends StatefulWidget {
  const TimePicker({super.key, required this.onTimeSelected});
  final ValueChanged<TimeOfDay> onTimeSelected;
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay getSelectedTime() {
    return _selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return MyButton(
      width: 100,
      onPressed: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
          initialEntryMode: TimePickerEntryMode.input,
          // builder: (context, child) {
          //   return Theme(
          //     data: Theme.of(context).copyWith(
          //       timePickerTheme: timePickerThemeData(context),
          //     ),
          //     child: child!,
          //   );
          // },
        );
        if (time != null) {
          setState(() {
            _selectedTime = time;
          });
          widget.onTimeSelected(_selectedTime);
        }
      },
      icon: Text(
        "${formatTimeOfDay(_selectedTime)}",
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    );
  }
}
