import 'dart:async';
import 'package:dehs/makeappointment1.dart';
import 'package:dehs/patient.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

String urldelete="http://mobilehost2019.com/LBAS/php/delete_ads.php";
String urlbook = "http://pickupandlaundry.com/dehs/php/bookappointment.php";
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
                                   
                  TableRow(children: [
                                  Text("0910 - 0925",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t0910==null?MaterialButton(
                                onPressed: _book0910,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                                  ]),
                                  
                   TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("0930 - 0945",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t0930==null?MaterialButton(
                                onPressed: _book0930,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                                  ]),
                  TableRow(children: [
                                  Text("0950 - 1005",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t0950==null?MaterialButton(
                                onPressed: _book0950,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1010 - 1025",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1010==null?MaterialButton(
                                onPressed: _book1010,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1030 - 1045",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1030==null?MaterialButton(
                                onPressed: _book1030,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1050 - 1105",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1050==null?MaterialButton(
                                onPressed: _book1050,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1110 - 1125",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1110==null?MaterialButton(
                                onPressed: _book1110,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1130 - 1145",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1130==null?MaterialButton(
                                onPressed: _book1130,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1150 - 1205",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1150==null?MaterialButton(
                                onPressed: _book1150,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1410 - 1425",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1410==null?MaterialButton(
                                onPressed: _book1410,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1430 - 1445",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1430==null?MaterialButton(
                                onPressed: _book1430,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1450 - 1505",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1450==null?MaterialButton(
                                onPressed: _book1450,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1510 - 1525",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1510==null?MaterialButton(
                                onPressed: _book1510,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1530 - 1545",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1530==null?MaterialButton(
                                onPressed: _book1530,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Text("1550 - 1605",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1550==null?MaterialButton(
                                onPressed: _book1550,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    child: Text("1610 - 1625",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                    ),
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1610==null?MaterialButton(
                                onPressed: _book1610,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                  TableRow(children: [
                    
                                  Text("1630 - 1645",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                  Container(
                                    height: 20,
                                child: Align(alignment: Alignment.center,
                                child:widget.doctor.t1630==null?MaterialButton(
                                onPressed: _book1630,
                                child: Text("Book",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),)
                                      :Text("Not Available",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                ),
                              ),
                  ]),
                 
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

  void _book0910() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 0910 - 0925?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t0910",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book0930() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 0930 - 0945?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t0930",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book0950() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 0950 - 1005?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t0950",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1010() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1010 - 1025?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1010",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1030() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1030 - 1045?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1030",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1050() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1050 - 1105?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1050",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1110() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1110 - 1125?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1110",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1130() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1130 - 1145?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1130",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1150() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1150 - 1205?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1150",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1410() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1410 - 1425?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1410",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1430() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1430 - 1445?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1430",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1450() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1450 - 1505?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1450",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1510() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1510 - 1525?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1510",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1530() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1530 - 1545?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1530",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1550() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1550 - 1605?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1550",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1610() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1610 - 1625?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1610",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
  void _book1630() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirm Booking 1630 - 1645?"),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                http.post(urlbook, body: {
                  "doctor": widget.doctor.email,
                  "patient": widget.patient.email,
                  "time": "t1645",
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
                    return;
                    });
                  } else {}
                }).catchError((err) {
                  print(err);
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
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/makeappointment.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Booking");
    pr.show();
    http.post(urlLoadJobs, body: {
      "patient": widget.patient.email,
      "booktime": time,
      "doctor": widget.doctor.email,
      
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Succesfully booked, please come 5 minutes earlier.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }
}