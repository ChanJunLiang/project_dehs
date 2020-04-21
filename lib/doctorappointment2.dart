import 'dart:convert';
import 'package:dehs/patient.dart';
import 'package:flutter/material.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/makeappointment1.dart';
import 'package:progress_dialog/progress_dialog.dart';

double perpage = 1;

class DoctorAppointment2 extends StatefulWidget {
  final Doctor doctor;
  final MakeAppointment1 makeappointment;
  DoctorAppointment2({Key key, this.doctor, this.makeappointment});

  @override
  _DoctorAppointment2State createState() => _DoctorAppointment2State();
}

class _DoctorAppointment2State extends State<DoctorAppointment2> {
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
                                  ),),

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

                                ],
                              ),
                      
                        ])
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
                          onTap: (){},
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            data[index]['p_email']
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                            Text(
                                            'start time: ${data[index]['starttime']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                            Text(
                                            'end time: ${data[index]['endtime']}',
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
    )));
  }


  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
     this.makeRequest();
    return null;
  }

  Future<String> makeRequest() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listappointment.php";
    
    http.post(urlLoadJobs, body: {
      "drid": widget.doctor.drid,
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


}

