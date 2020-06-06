import 'dart:convert';
import 'package:dehs/announcement.dart';
import 'package:dehs/appointment.dart';
import 'package:dehs/drapptdetail.dart';
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
  final Patient patient;
  final MakeAppointment1 makeappointment;
  DoctorAppointment2({Key key, this.doctor, this.makeappointment, this.patient});
  

  @override
  _DoctorAppointment2State createState() => _DoctorAppointment2State();
}

class _DoctorAppointment2State extends State<DoctorAppointment2> {
   GlobalKey<RefreshIndicatorState> refreshKey;
   final TextEditingController _anncontroller = TextEditingController();
   String message;
   bool edit=false;
   bool autof=false;

  List data;
  List ann;
  List announcementlist;
  List announcement;


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
                                  Stack(
                                    children:<Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(10,10,10,5),
                                      height: MediaQuery.of(context).size.height/5,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.teal[50],        
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(15,5,15,5),
                                          decoration: BoxDecoration(
                                          color: Colors.teal[100],
                                          border: Border.all(color: Colors.teal[300]),
                                          borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                          boxShadow: [BoxShadow(blurRadius: 10,color: Colors.teal[400],offset: Offset(0,0))]),
                                          child:TextField(
                                            autofocus: true,
                                            enabled: edit,
                                            controller: _anncontroller,
                                            keyboardType: TextInputType.multiline,    
                                            maxLines: 5, 
                                            scrollPadding: EdgeInsets.all(20.0),
                                            decoration: InputDecoration(
                                              labelText: ann[index]['announcement'].toString(),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                      
                                        ),
                                      ),
                                      Positioned(
                                        right: 15,
                                        top: 10,
                                        child: GestureDetector(
                                          onTap: _editAnnounce,
                                          child: Container(
                                            child: Icon(Icons.edit, color: Colors.blueGrey,)
                                          )
                                        )
                                      )
                                    ]
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
                          onTap: ()=> _onbookdetail(
                            data[index]['apptid'],
                            data[index]['dr_email'],
                            data[index]['drid'],
                            data[index]['dr_name'],
                            data[index]['dr_contact'],
                            data[index]['officecontact'],
                            data[index]['p_email'],
                            data[index]['p_name'],
                            data[index]['icno'],
                            data[index]['p_contact'],
                            data[index]['em_contact'],
                            data[index]['address'],
                            data[index]['booktime'],
                          ),
                          onLongPress: () => _onbookdelete(
                              data[index]['apptid'].toString(),
                              data[index]['dr_email'].toString(),
                              data[index]['p_email'].toString(),
                              data[index]['booktime'].toString()),
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
                                    'assets/images/dehslogoo.jpeg'
                                  )))),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            data[index]['p_email'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Appointment time: ${data[index]['booktime']}',
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
     this.getAnn();
    return null;
  }

  Future<String> makeRequest() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listappointment.php";
    
    http.post(urlLoadJobs, body: {
      "dr_email": widget.doctor.email,
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

  void _editAnnounce(){
    //----activate textfield----
    if(edit==false){  
      setState(() {
        edit=true; 
      });   
    }
    //----deactivate textfield----
    else if(edit==true){
      setState(() {
        edit=false;
        if(_anncontroller.text != null){
            _onpostannouncement();
        }
      });
    }
  }

  void _onpostannouncement() {
  String urlann = 'http://pickupandlaundry.com/dehs/php/postann.php';
    message = _anncontroller.text;

      if(message != 'null'){
        ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Posting announcement in progress");
      pr.show();
      http.post(urlann, body: {
        "message": message,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _anncontroller.text = '';
        pr.dismiss();
      }).catchError((err) {
        print(err);
      });
      } else {
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  void _onbookdetail(
      String apptid,
      String doctor,
      String drid,
      String dr_name,
      String dr_contact,
      String officecontact,
      String patient,
      String p_name,
      String icno,
      String p_contact,
      String em_contact,
      String address,
      String booktime,) {
    Appointment appointment = new Appointment(
        apptid: apptid,
        doctor: doctor,
        drid: drid,
        dr_name: dr_name,
        dr_contact: dr_contact,
        officecontact: officecontact,
        patient: patient,
        p_name: p_name,
        icno: icno,
        p_contact: p_contact,
        em_contact: em_contact,
        address: address,
        booktime: booktime, );
    //print(data);
    
    Navigator.push(
                context, MaterialPageRoute(builder: (context) => Drapptdetail(appointment: appointment, doctor: widget.doctor, patient: widget.patient)));
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

  Future<String> getAnn() async {
    String urlLoadann = "http://pickupandlaundry.com/dehs/php/getann.php";
    http.post(urlLoadann, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        ann = extractdata["announcement"];
        print("ann");
        print(ann);
        // pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      // pr.dismiss();
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
    this.getAnn();
  }

  

}


