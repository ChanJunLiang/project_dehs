import 'dart:convert';
import 'package:dehs/appointment.dart';
import 'package:dehs/doctor.dart';
import 'package:dehs/patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/makeappointment1.dart';
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;

class Drapptdetail extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;
  final Appointment appointment;
  Drapptdetail({Key key, this.appointment, this.doctor, this.patient});

  @override
  _DrapptdetailState createState() => _DrapptdetailState();
}

class _DrapptdetailState extends State<Drapptdetail> {
   GlobalKey<RefreshIndicatorState> refreshKey;

  List data;

  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    
   SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.teal[200]));
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
              
              body: RefreshIndicator(
              key: refreshKey,
              color: Colors.deepOrange,
              onRefresh: () async {
                await refreshList();
              },

              child:ListView.builder(
                  
                  itemCount: data == null ? 1 : data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                                Column(
                                children: <Widget>[
                                  

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Container(
                                    padding: EdgeInsets.fromLTRB(15,5,15,5),
                                    color: Colors.teal[400],
                                    child: Center(
                                    child: Text("Your Appointment",
                                    style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                                    ),),                            
                                    ),

                                    SizedBox(
                                      height: 4,
                                    ),
                                    
                                    Container(
                                padding: EdgeInsets.fromLTRB(15,15,15,15),
                                child: Align(alignment: Alignment.bottomCenter,
                                
                                ),
                              ),

                              SizedBox(
                                      height: 4,
                                    ),
                              

                                ],
                              ),
                      
                        ])
                      );
                    } 
                    index -= 1;
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Table(
                                defaultColumnWidth: FixedColumnWidth(1.0),
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children:[
                                  TableRow(children: [
                                  new Text("Appointment ID",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['apptid'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),
                                  

                                  TableRow(children: [
                                  new Text("Patient Email",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['p_email'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Patient Name",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['p_name'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("IC number",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['icno'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Contact number",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['p_contact'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Emergency Contact",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['em_contact'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Address",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['address'],
                                          style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  
                                  ]),

                                  TableRow(children: [
                                  Container(
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  Container(
                                    height: 18,
                                    child: Align(alignment: Alignment.center,
                                    
                                    ),
                                  ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Booking Time",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(data[index]['booktime'],
                                            style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  
                                  ]),
                                  
                                  ]
                                
                              ),

                              
                    );

                
                              
                  }),

                  
    )));
  }


  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
     this.makeRequest();
    return null;
  }

  Future<String> makeRequest() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/pappt.php";
    
    http.post(urlLoadJobs, body: {
      "p_email": widget.appointment.patient,
    }).then((res) {
      setState(() {
        print("get data here");
        var extractdata = json.decode(res.body);
        data = extractdata["appointment"];
        perpage = (data.length / 10);
        print("data");
        print(data);
      });
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  

  void _onbookdelete(String apptid, String doctor, String patient, String booktime) {
    print("Delete appointment of " + apptid);
    _showDialog(apptid, doctor, booktime);
  }

  void _showDialog(String apptid, String doctor, String booktime) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete appointment of " + apptid),
          content: new Text("Are your sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                deleteRequest(apptid, doctor, booktime);
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

  Future<String> deleteRequest(String apptid, String doctor, String booktime) async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/deleteappt.php";
    print('delete1');
    http.post(urlLoadJobs, body: {
      "apptid": apptid,
      "doctor": doctor,
      "booktime": booktime,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        deleteRequest2(apptid, doctor, booktime);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  Future<String> deleteRequest2(String apptid, String doctor, String booktime) async {
    String urlLoadJobs2 = "http://pickupandlaundry.com/dehs/php/deleteappt2.php";
    print('delete2');
    http.post(urlLoadJobs2, body: {
      "apptid": apptid,
      "doctor": doctor,
      "booktime": booktime,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Succesfully deleted the appointment.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        init();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
  }

  


}

