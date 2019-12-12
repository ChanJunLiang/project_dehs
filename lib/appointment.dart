import 'package:flutter/material.dart';
import 'package:dehs/mainscreen.dart';

class Appointment extends StatefulWidget {
    @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        backgroundColor: Colors.teal[50],
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text('Appointment'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Container(
              child: Text('Appointment'),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(),
        ));
    return Future.value(false);
  }
}
