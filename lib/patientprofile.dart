import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:dehs/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:dehs/splashscreen.dart';

String urlgetdriver = "http://pickupandlaundry.com/dehs/php/getdriver.php";
String urlupdate = "http://pickupandlaundry.com/dehs/php/updateprofile.php";
int number = 0;

class PatientProfile extends StatefulWidget {
  final Patient patient;

  PatientProfile({Key key, this.patient}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.teal[50],
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text('Profile', style: TextStyle(color:Colors.white)),
        ),
          body: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                         
                          Column(
                            children: <Widget>[
                              Container(
                              padding: EdgeInsets.fromLTRB(10,10,10,10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.teal[50],
                  
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5,15,15,15),
                                decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: Colors.teal[50]),
                                ),
                                child: Text(
                                  "NAME         :   " + widget.patient.name.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              ),

                              Container(
                              padding: EdgeInsets.fromLTRB(10,5,10,10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.teal[50],
                  
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5,15,15,15),
                                decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: Colors.teal[50]),
                                ),
                                child: Text(
                                  "EMAIL         :   " + widget.patient.email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              ),

                              Container(
                              padding: EdgeInsets.fromLTRB(10,5,10,10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.teal[50],
                  
                              child: Container(
                                padding: EdgeInsets.fromLTRB(5,15,15,15),
                                decoration: BoxDecoration(
                                color: Colors.teal[50],
                                border: Border.all(color: Colors.teal[50]),
                                ),
                                child: Text(
                                  "CONTACT   :   " + widget.patient.contact,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              ),

                              Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeName,
                                child: Text("CHANGE NAME"),),
                                ),
                              ),

                              Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changePassword,
                                child: Text("CHANGE PASSWORD"),),
                                ),
                              ),

                              Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeContact,
                                child: Text("CHANGE CONTACT"),),
                                ),
                              ),
                              

                              Container(
                                padding: EdgeInsets.fromLTRB(15,15,15,15),
                                child: Align(alignment: Alignment.bottomCenter,
                                child:RaisedButton(
                                  padding: EdgeInsets.fromLTRB(15,15,15,15),
                                  color: Colors.teal[100],
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                
                                onPressed: _logout,
                                child: Text("LOG OUT",
                                style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                      ),),
                                ),
                              ),

                            ],
                          ),
                        ]),
                        
                      ],
                    ),
                  );
                }

              }),
              
              
        ));
  }



  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', '');
    await prefs.setString('pass', '');
    print("LOGOUT");
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  void _changeName() {
    TextEditingController nameController = TextEditingController();
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change " + widget.patient.name),
          content: new TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.person),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (nameController.text.length < 5) {
                  Toast.show(
                      "Name should be more than 5 characters long", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.patient.email,
                  "name": nameController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.patient.name = dres[1];
                      if (dres[0] == "success") {
                        print("in setstate");
                        widget.patient.name = dres[1];
                      }
                    });
                  } else {}
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

  void _changePassword() {
    TextEditingController passController = TextEditingController();
    // flutter defined function
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Password for " + widget.patient.name),
          content: new TextField(
            controller: passController,
            decoration: InputDecoration(
              labelText: 'New Password',
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (passController.text.length < 5) {
                  Toast.show("Password too short", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.patient.email,
                  "password": passController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.patient.name = dres[1];
                      if (dres[0] == "success") {
                        Toast.show("Success", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            savepref(passController.text);
                            Navigator.of(context).pop();
                      }
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

  void _changeContact() {
    TextEditingController phoneController = TextEditingController();
    // flutter defined function
    print(widget.patient.name);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change contact for" + widget.patient.name),
          content: new TextField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'phone',
                icon: Icon(Icons.phone),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (phoneController.text.length < 5) {
                  Toast.show("Please enter correct phone number", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      return;
                }
                http.post(urlupdate, body: {
                  "email": widget.patient.email,
                  "phone": phoneController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.patient.contact = dres[3];
                      Toast.show("Success ", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      Navigator.of(context).pop();
                      return;
                    });
                  }
                  
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


  void savepref(String pass) async {
    print('Inside savepref');
    SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('pass', pass);
  }



    
}



