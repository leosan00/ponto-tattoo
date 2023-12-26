import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponto_tattoo/repositories/user_repository.dart';
import 'package:ponto_tattoo/style/app_ponto_style.dart';
import 'package:ponto_tattoo/ui/login/login_page.dart';
import 'package:ponto_tattoo/ui/payment/clients/payment_client_initial_page.dart';
import 'package:ponto_tattoo/ui/session_journey/form_register_evaluation_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  final description;
  final dateEvent;

  SchedulePage({this.dateEvent, this.description});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  Map<DateTime, List> _holidays;
  List _selectedEvents;
  List _selectedHolidays;
  AnimationController _animationController;
  CalendarController _calendarController;

  TextEditingController _editingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    final _selectedDay = DateTime.now();

    _holidays = {
      _selectedDay.add(Duration(days: 3)): ['Natal'],
      _selectedDay.add(Duration(days: 10)): ['Dia da bandeira'],
      _selectedDay.add(Duration(days: 6)): ['Dia da Consciência Negra'],
    };

    getEvents();

    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedHolidays = _holidays[_selectedDay] ?? [];
    print(' eventos novos $_events');

    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  void getEvents() async {

    var snapshot = await Firestore.instance.collection('events').getDocuments();
    
    setState(() {
      snapshot.documents.forEach((element) {
        var newDate = DateTime.parse(element.data['date']);
        if(_events[newDate] == null){
          _events[newDate] = [];
        }
        if (element.data['date'] != null && element.data['event'] != null) {
          _events[newDate].add(element.data['event'].toString());
        }
      });


    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.all(16),
        //     icon: Icon(Icons.add),
        //     color: Colors.white,
        //     onPressed: () {
        //       _showAddDialog();
        //     },
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              // Switch out 2 lines below to play with TableCalendar's settings
              //-----------------------
              //_buildTableCalendar(),
              _buildTableCalendarWithBuilders(),
              const SizedBox(height: 40.0),
              //_buildButtons()
              Expanded(child: _buildEventList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicione um novo evento:'),
        content: TextField(
          controller: _editingController,
        ),
        actions: [
          FlatButton(
            child: Text("Salvar"),
            onPressed: () {
              if (_editingController.text.isEmpty) return;
              setState(() {
                addNewEvent(_editingController, _events);
              });
            },
          )
        ],
      ),
    );
    return null;
  }

  void addNewEvent(TextEditingController _editingController, _events) {
    _events[_calendarController.selectedDay] = [_editingController.text];
    _selectedEvents.add(_editingController.text);
    //print('$_events');

    Navigator.of(context).pop();
    _editingController.text = '';
    _buildEventList();
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'PT_BR',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.horizontalSwipe,
      availableCalendarFormats: const {
        CalendarFormat.month: 'mês',
        CalendarFormat.week: 'semana',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekdayStyle:
            TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        weekendStyle: TextStyle().copyWith(color: Colors.lightBlue),
        holidayStyle: TextStyle().copyWith(color: Colors.lightBlue),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        weekendStyle: TextStyle().copyWith(color: Colors.lightBlue),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: true,
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
          size: 30,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
          size: 30,
        ),
        titleTextStyle: TextStyle(
            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT, fontSize: 19),
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: events != null
                    ? AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE
                    : Color.fromRGBO(51, 92, 103, 1),
              ),
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style:
                    TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)
                        .copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromRGBO(51, 92, 103, 0.5),
            ),
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT)
                  .copyWith(fontSize: 16.0),
            ),
          );
        },
        holidayDayBuilder: (context, date, holidays) {
          return Container(
            alignment: Alignment.center,
            height: 50,
            width: 50,
            color: _calendarController.isSelected(date)
                ? Color.fromRGBO(86, 238, 244, 1)
                : Colors.transparent,
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: Colors.lightBlue,
              ),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(date, holidays),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
        _calendarController.setCalendarFormat(CalendarFormat.week);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Color.fromRGBO(120, 1, 22, 0.8)
            : _calendarController.isToday(date)
                ? AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE
                : AppPontoStyle.COLOR_THEME_HIGHLIGHT_ORANGE,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker(DateTime date, List holidays) {
    getSelectedHoliday(date, holidays);

    return Icon(
      Icons.power_settings_new,
      size: 20.0,
      color: Colors.lightBlue,
    );
  }

  // Widget _buildButtons() {
  //   final dateTime = _events.keys.elementAt(_events.length - 2);
  //
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           RaisedButton(
  //             child: Text('Month'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.month);
  //               });
  //             },
  //           ),
  //           RaisedButton(
  //             child: Text('2 weeks'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController
  //                     .setCalendarFormat(CalendarFormat.twoWeeks);
  //               });
  //             },
  //           ),
  //           RaisedButton(
  //             child: Text('Week'),
  //             onPressed: () {
  //               setState(() {
  //                 _calendarController.setCalendarFormat(CalendarFormat.week);
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 8.0),
  //       RaisedButton(
  //         child: Text(
  //             'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
  //         onPressed: () {
  //           _calendarController.setSelectedDay(
  //             DateTime(dateTime.year, dateTime.month, dateTime.day),
  //             runCallback: true,
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  Widget _buildEventList() {
    if (_selectedEvents.length != 0) {
      return ListView(
        shrinkWrap: true,
        children: _selectedEvents
            .map((event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8,color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text(event.toString(),style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => EventPageDetail(event)
                      // ));
                    },
                  ),
                ))
            .toList(),
      );
    } else {
      return Container(
        child: Text(
          'Sem eventos hoje',
          style: TextStyle(color: AppPontoStyle.COLOR_THEME_TEXT_HIGHLIGHT),
        ),
      );
    }
  }

  void getSelectedHoliday(DateTime date, List holidays) {
    if (_calendarController.isSelected(date)) {
      //print('$holidays');
    }
  }
}

//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         body: SafeArea(
//       child: Container(
//         color: AppPontoStyle.COLOR_THEME_BACKGROUND_APP,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               RaisedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PaymentClientInitialPage(null)),
//                   );
//                 },
//                 color: Colors.black87,
//                 child: Text(
//                   "Ir para pagamento",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               RaisedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 },
//                 color: Colors.black87,
//                 child: Text(
//                   "Ir para login",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               RaisedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => FormRegisterEvaluationPage()),
//                   );
//                 },
//                 color: Colors.black87,
//                 child: Text(
//                   "Registrar avaliação",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 20),
//               RaisedButton(
//                 onPressed: () {
//                   UserRepository repo = UserRepository();
//                   try {
//                     repo.deleteAllUser();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   } catch (e) {
//                     print("erro:|$e|");
//                   }
//                 },
//                 color: Colors.black87,
//                 child: Text(
//                   "Logout",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [Text("")],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
