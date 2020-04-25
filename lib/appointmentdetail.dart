import 'dart:async';
import 'package:dehs/mainscreen.dart';
import 'package:dehs/makeappointment1.dart';
import 'package:dehs/patient.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

String urldelete="http://mobilehost2019.com/LBAS/php/delete_ads.php";
String urlbook = "http://pickupandlaundry.com/dehs/php/makeappointment.php";
List data;

class AppointmentDetail extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;

  const AppointmentDetail({Key key, this.doctor, this.patient}) : super(key: key);

  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.tealAccent));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold( 
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.teal[100],
          appBar: AppBar(
            title: Text('DOCTOR DETAILS'),
            backgroundColor: Colors.teal[300],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                doctor: widget.doctor,
                patient: widget.patient,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MakeAppointment1(),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;
  DetailInterface({this.doctor, this.patient});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  void initState() {
    super.initState();
    print('here is detail');
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text('Dr. '+widget.doctor.name.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Container(
            child: Column(
              
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.teal[100],
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(1.0),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                  TableRow(children: [
                    Text("Doctor Email",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.email,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Doctor ID",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.drid,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Contact Number",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.contact,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Office Contact",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.officecontact,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 30,
                      ),SizedBox(
                        height: 30,
                      ),
                  ]),
                  TableRow(children: [
                    Container(
                      height: 25,
                      color: Colors.teal[200],
                      child: Text("Make Appointment",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                    ),
                        SizedBox(
                        height: 10,
                      ),                    
                  ]),

                  timetable1("09.10am - 09.25am", "t0910", widget.doctor.t0910),
                  timetable2("09.30am - 09.45am", "t0930", widget.doctor.t0930),
                  timetable1("09.50am - 10.05am", "t0950", widget.doctor.t0950),
                  timetable2("10.10am - 10.25am", "t1010", widget.doctor.t1010),
                  timetable1("10.30am - 10.45am", "t1030", widget.doctor.t1030),
                  timetable2("10.50am - 11.05am", "t1050", widget.doctor.t1050),
                  timetable1("11.10am - 11.25am", "t1110", widget.doctor.t1110),
                  timetable2("11.30am - 11.45am", "t1130", widget.doctor.t1130),
                  timetable1("11.50am - 12.05am", "t1150", widget.doctor.t1150),
                  timetable2("02.10pm - 02.25pm", "t1410", widget.doctor.t1410),
                  timetable1("02.30pm - 02.45pm", "t1430", widget.doctor.t1430),
                  timetable2("02.50pm - 03.05pm", "t1450", widget.doctor.t1450),
                  timetable1("03.10pm - 03.25pm", "t1510", widget.doctor.t1510),
                  timetable2("03.30pm - 03.45pm", "t1530", widget.doctor.t1530),
                  timetable1("03.50pm - 04.05pm", "t1550", widget.doctor.t1550),
                  timetable2("04.10pm - 04.25pm", "t1610", widget.doctor.t1610),
                  timetable1("04.30pm - 04.45pm", "t1630", widget.doctor.t1630),                
                ]),
                
              ),
              SizedBox(
                height: 10,
              ),
             
              
            ],
          ),
        ),
      ],
    );
  }
  

  TableRow timetable1(String period, String time, String availTime){
    return TableRow(children: [
                Text(period,
      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                Container(
                  height: 20,
              child: Align(alignment: Alignment.center,
              child:availTime==null?MaterialButton(
              onPressed: ()=> {onBook(period, time, availTime)},
              child: Text("Book",style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),),)
                    :Text("Not Available",
      style: TextStyle(fontSize: 16)),
              ),
            ),
    ]);
  }

  TableRow timetable2(String period, String time, String availTime){
    return TableRow(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[200],
                ),
                child: Text(period,
    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[200],
                ),
                height: 20,
            child: Align(alignment: Alignment.center,
            child:availTime==null?MaterialButton(
            onPressed: ()=> {onBook(period, time, availTime)},
            child: Text("Book",style: TextStyle(
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16),),)
                  :Text("Not Available",
    style: TextStyle(fontSize: 16)),
            ),
          ),
              ]);
  }

  void onBook(String period, String time, String availTime){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking $period?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "drid": widget.doctor.drid,
                  "dr_name": widget.doctor.name,
                  "dr_contact": widget.doctor.contact,
                  "officecontact": widget.doctor.officecontact,
                  "patient": widget.patient.email,
                  "p_name": widget.patient.name,
                  "icno": widget.patient.icno,
                  "p_contact": widget.patient.contact,
                  "em_contact": widget.patient.em_contact,
                  "address": widget.patient.address,
                  "time": time,
                  
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    acceptRequest(time);
                    });
                  } else {
                    Toast.show("Failed to book, please check your appointment.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);}
                }).catchError((err) {
                  print(err);
                  print('hello1');
                  
                });
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> acceptRequest(String time) async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/bookappointment.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Booking");
    pr.show();
    http.post(urlLoadJobs, body: {
                  "doctor": widget.doctor.email,
                  "drid": widget.doctor.drid,
                  "dr_name": widget.doctor.name,
                  "dr_contact": widget.doctor.contact,
                  "officecontact": widget.doctor.officecontact,
                  "patient": widget.patient.email,
                  "p_name": widget.patient.name,
                  "icno": widget.patient.icno,
                  "p_contact": widget.patient.contact,
                  "em_contact": widget.patient.em_contact,
                  "address": widget.patient.address,
                  "time": time,
      
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Succesfully booked, please come 5 minutes earlier.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
      } else {
        print('hello2');
            Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
      _onLogin(widget.patient.email, context);
    });
    return null;
  }

  void _onLogin(String email, BuildContext ctx) {
     String urlgetuser = "http://pickupandlaundry.com/dehs/php/getpatient.php";

    http.post(urlgetuser, body: {
      "email": widget.patient.email,
    }).then((res) {
      print(res.statusCode);
      var string = res.body;
      List dres = string.split(",");
      print(dres);
      if (dres[0] == "success") {
        Patient patient = new Patient(
            name: dres[1],
            email: dres[2],
            icno: dres[3],
            contact: dres[4],
            em_contact: dres[5],
            address: dres[6]);
        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => MainScreen(patient: patient)));
      }
    }).catchError((err) {
      print(err);
    });
  }
}

