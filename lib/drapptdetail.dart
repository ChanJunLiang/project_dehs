import 'dart:async';
import 'package:dehs/doctormain.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dehs/appointment.dart';
import 'package:dehs/doctor.dart';
import 'doctormain.dart';

class Drapptdetail extends StatefulWidget {
  final Appointment appointment;
  final Doctor doctor;
 

  const Drapptdetail({Key key, this.appointment, this.doctor}) : super(key: key);

  @override
  _DrapptdetailState createState() => _DrapptdetailState();
}

class _DrapptdetailState extends State<Drapptdetail> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.teal));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('APPOINTMENT DETAILS'),
            backgroundColor: Colors.teal[200],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                appointment: widget.appointment,
                doctor: widget.doctor,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorMain(
            doctor: widget.doctor,
          ),
        ));
    return Future.value(false);
  }

}

class DetailInterface extends StatefulWidget {
  final Appointment appointment;
  final Doctor doctor;
  DetailInterface({this.appointment, this.doctor});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {

 

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        Center(),
        Container(
          width: 280,
          height: 200,
         
        ),
        SizedBox(
          height: 10,
        ),
        Text(widget.appointment.apptid,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Table(children: [
                TableRow(children: [
                  Text("Patient email: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.appointment.patient.toString()),
                ]),
                TableRow(children: [
                  Text("Booking time: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.appointment.booktime.toString()),
                ]),
                
               
                
                

                
              ]),
              SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ],
    );
  }

}
