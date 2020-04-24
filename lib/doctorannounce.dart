import 'dart:convert';

import 'package:dehs/appointmentdetail.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/material.dart';
import 'package:dehs/doctor.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dehs/announcement.dart';


String urlUpload = "http://pickupandlaundry.com/dehs/php/postann.php";
int number = 0;
double perpage = 1;
TextEditingController annController = TextEditingController();
String message;

class Doctorannouncement extends StatefulWidget {
  final Announcement announcement;
  final Doctor doctor;
  
  Doctorannouncement({Key key, this.doctor, this.announcement}) : super(key: key);
    @override
  _DoctorannouncementState createState() => _DoctorannouncementState();
}

class _DoctorannouncementState extends State<Doctorannouncement> {
  List announcement;
  List announcementList;
  List data;
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  initState() {
    super.initState();
    getAnnouncement();    
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
            title: Text('Announcement'),
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

                SizedBox(
                  height: 15,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(15,5,15,5),
                  color: Colors.teal[400],
                  child: Center(
                  child: Text("Announcement",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                   color: Colors.white)
                   ),),                            
                   ),

                   Container(
                                color: Colors.teal,
                                child:MaterialButton(
                                onPressed: _makeannouncement,
                                child: Text("Make Announcement",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                        
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
                                                    child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                  Expanded(
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                            data[index]['message'],
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
    this.getAnnouncement();
    //_getCurrentLocation();
  } 

  Future<String> getAnnouncement() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/getann.php";
    http.post(urlLoadJobs, body: {
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["announcement"];
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

  

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    this.getAnnouncement();
    return null;
  }

  void _makeannouncement() {
    TextEditingController annController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Make announcement"),
          content: new TextField(
              controller: annController,
              decoration: InputDecoration(
                labelText: 'insert announcement',
                icon: Icon(Icons.mail),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                uploadData();
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
  

  void uploadData() {
    message = annController.text;

    if (annController.text.length>1) {
     Toast.show("Uploading", context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      http.post(urlUpload, body: {
        "message": message,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        
                Navigator.of(context).pop();
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }


  
}
