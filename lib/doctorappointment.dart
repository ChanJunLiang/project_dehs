import 'package:flutter/material.dart';
import 'package:dehs/doctor.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/makeappointment1.dart';

String urlgetdriver = "http://pickupandlaundry.com/dehs/php/getdriver.php";
String urlupdate = "http://pickupandlaundry.com/dehs/php/makeappointment.php";
int number = 0;
double perpage = 1;


class DoctorAppointment extends StatefulWidget {
  final Doctor doctor;
  final MakeAppointment1 makeappointment;
  DoctorAppointment({Key key, this.doctor, this.makeappointment}) : super(key: key);
    @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  List data;
  @override
  Widget build(BuildContext context) {

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
                    child: Text('No pending appointment for today.', style: TextStyle(fontSize: 20)),
                  ),
                  
                  
                ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15,5,15,5),
                  color: Colors.teal[400],
                  child: Center(
                  child: Text("Appointment List Today",
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
                     child:ListView.builder(
                       itemCount: data == null ? 1 : data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == data.length && perpage > 1) {
                      return Container(
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
                            child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white),
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                    'assets/images/dehslogo.png'
                                  )))),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['p_email']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Time " + data[index]['appointmenttime']),
                                        
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
                      },
                     ),
                   ),

                   
              ],
            ),

          ),
        ),
    );
  }


  
}
