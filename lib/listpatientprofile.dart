import 'dart:convert';
import 'package:dehs/admin.dart';
import 'package:dehs/patient.dart';
import 'package:dehs/patientdetail.dart';
import 'package:dehs/patientregister.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int number = 0;
double perpage = 1;

class ListPatientProfile extends StatefulWidget {
  final Admin admin;
  
  ListPatientProfile({Key key, this.admin}) : super(key: key);
    @override
  _ListPatientProfileState createState() => _ListPatientProfileState();
}

class _ListPatientProfileState extends State<ListPatientProfile> {
  List patient;
  List patientList;
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
            title: Text('Patient'),
          ),
          body: RefreshIndicator(
            
              key: refreshKey,
              color: Colors.teal[400],
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
                padding: EdgeInsets.fromLTRB(15,15,15,15),
                decoration: BoxDecoration(
                color: Colors.teal[100],
                border: Border.all(color: Colors.teal[300]),
                borderRadius: BorderRadius.all(
                Radius.circular(10.0)),
                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.teal[400],offset: Offset(0,0))]),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    height: 50,
                    minWidth: 50,
                    child: Text('Register Patient'),
                    color: Colors.teal[200],
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: _onRegisterPatient,
                  ),
              ),
                
                
              ),

                SizedBox(
                  height: 15,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15,5,15,5),
                  color: Colors.teal[400],
                  child: Center(
                  child: Text("List of Patients ",
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
                          onTap: () => _onPatientDetail(
                            data[index]['p_name'],
                            data[index]['p_email'],
                            data[index]['contact'],
                            data[index]['icno'],
                            data[index]['em_contact'],
                            data[index]['address'],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                  Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['p_name']
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
    //_getCurrentLocation();
  } 

  Future<String> getDoctor() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listpatients.php";
    http.post(urlLoadJobs, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["patients"];
        print("data");
        print(data);
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    return null;
  }

  void _onPatientDetail(
      String name,
      String email,
      String contact,
      String icno,
      String em_contact,
      String address) {
    Patient patient = new Patient(
        name: name,
        email: email,
        contact: contact,
        icno: icno,
        em_contact: em_contact,
        address: address);
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientDetail(patient: patient)));
  }

  void _onRegisterPatient(){
    print('onRegisterPatient');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PatientRegister()));
    }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.getDoctor();
    return null;
  }

  
}
