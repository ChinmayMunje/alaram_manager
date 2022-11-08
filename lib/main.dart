import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      title: 'Alarm Application',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // creating text ediiting controller to take hour
  // and minute as input
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;

      // minuteController.text = _time.minute.toInt() as String;
      // hourController.text = _time.hour.toInt() as String;
      print("Pick time is : " + _time.toString());

      FlutterAlarmClock.createAlarm(_time.hour, _time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Manager'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: <Widget>[
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/alarm.png', height: 140, width: 140),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Welcome to Alarm Manager Application",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            // show alarm
            FlutterAlarmClock.showAlarms();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Show Alarms',
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        ),
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
            selectTime(context);
          },
        ),
      ),
    );
  }
}
