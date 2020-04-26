import 'dart:convert';

import 'package:dehs/announcement.dart';
import 'package:dehs/appointmentdetail.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/material.dart';
import 'package:dehs/patient.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/appointment.dart';


String urlupdate = "http://pickupandlaundry.com/dehs/php/makeappointment.php";
int number = 0;
double perpage = 1;

class MakeAppointment1 extends StatefulWidget {
  final Patient patient;
  final Appointment appointment;
  final Announcement announcement;
  
  MakeAppointment1({Key key, this.patient, this.appointment, this.announcement}) : super(key: key);
    @override
  _MakeAppointment1State createState() => _MakeAppointment1State();
}

class _MakeAppointment1State extends State<MakeAppointment1> {
  List doctor;
  List doctorList;
  List data;
  List message;
  List announcementlist;
  List announcement;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  initState() {
    super.initState();
    getDoctor();    
    getAnn();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          home: Scaffold(
          backgroundColor: Colors.teal[50],
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.teal[300],
            title: Text('Appointment'),
          ),
          body: RefreshIndicator(
            
              key: refreshKey,
              color: Colors.deepOrange,
              onRefresh: () async {
                await refreshList();
              },

            child:ListView.builder(
              //Step 6: Count the data
              itemCount: data == null ? 1 : data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    child: Column(
                      children: <Widget>[
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
                child: Text(message[index]['announcement'].toString(), style: TextStyle(fontSize: 20)),
              ),
                
                
              ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15,5,15,5),
                  color: Colors.teal[400],
                  child: Center(
                  child: Text("Choose doctor to make Appointment ",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                   color: Colors.white)
                   ),),                            
                   ),
                          ],
                        ),
                      );
                    }
                    if (index == data.length && perpage > 1) {
                      return Container(
                        width: 250,
                        color: Colors.white,
                        child: MaterialButton(
                          child: Text(
                            "Load More",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {},
                        ),
                      );
                    }
                    index -= 1;
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 2,
                        child: InkWell(
                          onTap: () => _onDrDetail(
                            data[index]['dr_name'],
                            data[index]['dr_email'],
                            data[index]['contact'],
                            data[index]['drid'],
                            data[index]['icno'],
                            data[index]['officecontact'],
                            data[index]['address'],
                            data[index]['t0910'],
                            data[index]['t0930'],
                            data[index]['t0950'],
                            data[index]['t1010'],
                            data[index]['t1030'],
                            data[index]['t1050'],
                            data[index]['t1110'],
                            data[index]['t1130'],
                            data[index]['t1150'],
                            data[index]['t1410'],
                            data[index]['t1430'],
                            data[index]['t1450'],
                            data[index]['t1510'],
                            data[index]['t1530'],
                            data[index]['t1550'],
                            data[index]['t1610'],
                            data[index]['t1630'],),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                  Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['dr_name']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

          ),
        ),
    );
  }



  Future init() async {
    this.getDoctor();
    this.getAnn();
  } 

  Future<String> getDoctor() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listdoctors.php";
    http.post(urlLoadJobs, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["doctors"];
        print("data");
        print(data);
        // pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    return null;
  }

  Future<String> getAnn() async {
    String urlLoadann = "http://pickupandlaundry.com/dehs/php/getann.php";
    http.post(urlLoadann, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        message = extractdata["announcement"];
        print("message");
        print(message);
        // pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    return null;
  }

  void _onDrDetail(
      String name,
      String email,
      String contact,
      String drid,
      String icno,
      String officecontact,
      String address,
      String t0910,
      String t0930,
      String t0950,
      String t1010,
      String t1030,
      String t1050,
      String t1110,
      String t1130,
      String t1150,
      String t1410,
      String t1430,
      String t1450,
      String t1510,
      String t1530,
      String t1550,
      String t1610,
      String t1630) {
    Doctor doctor = new Doctor(
        name: name,
        email: email,
        contact: contact,
        drid: drid,
        icno: icno,
        officecontact: officecontact,
        address: address,
        t0910: t0910,
        t0930: t0930,
        t0950: t0950,
        t1010: t1010,
        t1030: t1030,
        t1050: t1050,
        t1110: t1110,
        t1130: t1130,
        t1150: t1150,
        t1410: t1410,
        t1430: t1430,
        t1450: t1450,
        t1510: t1510,
        t1530: t1530,
        t1550: t1550,
        t1610: t1610,
        t1630: t1630);
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentDetail(doctor: doctor, patient: widget.patient)));
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.getDoctor();
    this.getAnn();
    return null;
  }


  
}
