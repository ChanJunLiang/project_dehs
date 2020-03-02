import 'dart:convert';

import 'package:dehs/staff.dart';
import 'package:flutter/material.dart';
import 'package:dehs/patient.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/makeappointment.dart';

String urlupdate = "http://pickupandlaundry.com/dehs/php/makeappointment.php";
int number = 0;


class Appointment extends StatefulWidget {
  final Patient patient;
  final MakeAppointment makeappointment;
  
  Appointment({Key key, this.patient, this.makeappointment}) : super(key: key);
    @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List doctor;
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedStaff;

  @override
  initState() {
    super.initState();
    getDoctor();
    
  }

  @override
  Widget build(BuildContext context) {
    _dropdownMenuItems = buildDropdownMenuItems(doctor);
    _selectedStaff = _dropdownMenuItems[0].value;
    return MaterialApp(
          home: Scaffold(
          backgroundColor: Colors.teal[50],
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.teal[300],
            title: Text('Appointment'),
          ),
          body: SingleChildScrollView(
            
            child:Column(
              children: <Widget>[

                SizedBox(
                  height: 15,
                ),
                
                Container(
                  padding: EdgeInsets.fromLTRB(10,10,10,5),
                  height: MediaQuery.of(context).size.height/5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.teal[50],
                  
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15,15,15,5),
                    decoration: BoxDecoration(
                    color: Colors.teal[100],
                    border: Border.all(color: Colors.teal[300]),
                    borderRadius: BorderRadius.all(
                    Radius.circular(10.0)),
                    boxShadow: [BoxShadow(blurRadius: 10,color: Colors.teal[400],offset: Offset(0,0))]),
                    child: Text('This will be notification', style: TextStyle(fontSize: 20)),
                  ),
                  
                  
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15,5,15,5),
                  color: Colors.teal[400],
                  child: Center(
                  child: Text("Your Appointment ",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                   color: Colors.white)
                   ),),                            
                   ),

                   Container(
                   padding: EdgeInsets.fromLTRB(15,15,15,15),
                   child: Align(alignment: Alignment.bottomCenter,
                   child:RaisedButton(
                   padding: EdgeInsets.fromLTRB(15,15,15,15),
                   color: Colors.teal[100],
                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                  
                   onPressed: _makeappointment,
                   child: Text("MAKE APPOINTMENT",
                   style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 14),
                   ),),
                  ),
                  ),
              ],
            ),

          ),
        ),
    );
  }

void _makeappointment(){
TextEditingController appmtController = TextEditingController();
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Make Appointment? Mr. " + widget.patient.name.toUpperCase()),
          content: Column(
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Text("Choose doctor:", style: TextStyle(fontSize: 18), textAlign: TextAlign.left,),

              ),),
              Flexible(
                    child:Container(
                      height: 40,
                      width: 75,
                      
                      child: DropdownButton(
                        value: _selectedStaff,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                      )
              ),
              Flexible(
                    child: new TextField(
                    //controller: ,
                    decoration: InputDecoration(
                      labelText: 'Preferrable Doctor',
                      icon: Icon(Icons.person),
                    )),
              ),
            ],
          ),
              
              
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                
                if (appmtController.text == null) {
                  Toast.show(
                      "Please input desirable appointment time.", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.patient.email,
                  "makeappointment": appmtController.text,
                }).then((res) {
                  print(res.statusCode);
                  var string = res.body;
                  List dres = string.split(",");
                  print(dres);
                }).catchError((err) {
                  print(err);
                });
                Navigator.of(context).pop();
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
 onChangeDropdownItem(String selectedStaff) {
    setState(() {
      _selectedStaff = selectedStaff;
    });
  }  

  getDoctor() {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listdoctors.php";
    http.post(urlLoadJobs, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        doctor = extractdata["doctors"];
        print("data");
        print(doctor);
        // pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    return null;
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(List doctor)  {
    List<DropdownMenuItem<String>> items = new List();
    if(doctor==null){
      items.add(DropdownMenuItem(value: "null",
      child: Text("null")));
    }else{
    for (int i=0; i < doctor.length; i++){
      items.add(DropdownMenuItem(value: doctor[i]["s_name"],
      child: Text(doctor[i]["s_name"])));
    }}
    return items;
  }

  // List<Doctor> getDoctor(doctors){
  //  String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listdoctors.php";
  //   http.post(urlLoadJobs, body: {
      
  //   }).then((res) {
  //     setState(() {
  //       var extractdata = json.decode(res.body);
  //       doctors = extractdata["doctorlist"];
  //       print("data");
  //       print(doctors);
  //     });
  //   }).catchError((err) {
  //     print(err);
  //   });
  //   return null;
  // }
  
}
