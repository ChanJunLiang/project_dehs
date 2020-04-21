import 'dart:convert';

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
  
  MakeAppointment1({Key key, this.patient, this.appointment}) : super(key: key);
    @override
  _MakeAppointment1State createState() => _MakeAppointment1State();
}

class _MakeAppointment1State extends State<MakeAppointment1> {
  List doctor;
  List doctorList;
  List data;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  initState() {
    super.initState();
    getDoctor();    
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
                            data[index]['address'],),
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
                                        // Text(data[index]['contact']),
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
    //_getCurrentLocation();
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

  void _onDrDetail(
      String name,
      String email,
      String contact,
      String drid,
      String icno,
      String officecontact,
      String address,) {
    Doctor doctor = new Doctor(
        name: name,
        email: email,
        contact: contact,
        drid: drid,
        icno: icno,
        officecontact: officecontact,
        address: address);
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AppointmentDetail(doctor: doctor, patient: widget.patient)));
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.getDoctor();
    return null;
  }


  
}
