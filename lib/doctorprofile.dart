import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:dehs/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:dehs/main.dart';

String urlgetdoctor = "http://pickupandlaundry.com/dehs/php/getdoctor.php";
String urlupdate = "http://pickupandlaundry.com/dehs/php/doctorupdateprofile.php";
int number = 0;

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;

  DoctorProfile({Key key, this.doctor}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
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
          resizeToAvoidBottomPadding: true,
          appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text('Profile', style: TextStyle(color:Colors.white)),
        ),
          body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                              padding: EdgeInsets.fromLTRB(10,10,10,0),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.teal[50],
                  
                              child: Table(
                                defaultColumnWidth: FixedColumnWidth(1.0),
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children:[
                                  TableRow(children: [
                                  new Text("Name",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text((widget.doctor.name).toUpperCase(),style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(                                    
                                child:MaterialButton(
                                onPressed: _changeName,
                                child: Text("UPDATE",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                        
                              ),
                                  ]),

                                  TableRow(children: [
                                  new Text("ID Number",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text(widget.doctor.drid??'NULL',style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                        Container(
                                  child: Align(alignment: Alignment.center,
                                  
                                  ),
                                ),
                                      
                                  ]),
                                  
                                  TableRow(children: [
                                  new Text("Ic Number",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text(widget.doctor.icno??'null',style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeICno,
                                child: Text("UPDATE",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                                ),
                              ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Email",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text(widget.doctor.email,style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(
                                child: Align(alignment: Alignment.center,
                                
                                ),
                              ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Address",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  
                                  new Text(widget.doctor.address??"null",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeAddress,
                                child: Text("UPDATE",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                                ),
                              ),
                                  ]),
                                  
                                  TableRow(children: [
                                  new Text("Contact",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text(widget.doctor.contact,style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeContact,
                                child: Text("UPDATE",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                                ),
                              ),
                                  ]),

                                  TableRow(children: [
                                  new Text("Office Contact", style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  new Text(widget.doctor.officecontact??"null", style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),),
                                  Container(
                                child: Align(alignment: Alignment.center,
                                child:MaterialButton(
                                onPressed: _changeOfficeContact,
                                child: Text("UPDATE",style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),),),
                                ),
                              ),
                                  ]),
                                  
                                  ]
                                
                              ),
                              ),

                              Container(
                                padding: EdgeInsets.fromLTRB(15,15,15,15),
                                child: Align(alignment: Alignment.bottomCenter,
                                child:RaisedButton(
                                  padding: EdgeInsets.fromLTRB(15,15,15,15),
                                  color: Colors.teal[100],
                                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                
                                onPressed: _changePassword,
                                child: Text("CHANGE PASSWORD",
                                style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                      ),),
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
                        
                      ],
                    ),
                  )
                
              
              
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
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change " + widget.doctor.name),
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
                if (nameController.text.length < 4) {
                  Toast.show(
                      "Name should be more than 4 characters long", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.doctor.email,
                  "name": nameController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.doctor.name = dres[1];
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

  void _changeAddress() {
    TextEditingController addressController = TextEditingController();
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Address?"),
          content: new TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                icon: Icon(Icons.person),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (addressController.text.length < 5) {
                  Toast.show(
                      "Please insert accurate address", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.doctor.email,
                  "address": addressController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.doctor.address = dres[6];
                      Toast.show("Success.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    Navigator.of(context).pop();
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

  void _changePassword() {
    TextEditingController passController = TextEditingController();
    // flutter defined function
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Password"),
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
                  "email": widget.doctor.email,
                  "password": passController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.doctor.name = dres[1];
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

  void _changeICno() {
    TextEditingController icnoController = TextEditingController();
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change IC number"),
          content: new TextField(
            keyboardType: TextInputType.number,
              controller:icnoController,
              decoration: InputDecoration(
                labelText: 'IC no',
                icon: Icon(Icons.person),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (icnoController.text.length < 5) {
                  Toast.show(
                      "Please insert correct IC number", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  return;
                }
                http.post(urlupdate, body: {
                  "email": widget.doctor.email,
                  "icno": icnoController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.doctor.icno = dres[4];
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

  void _changeContact() {
    TextEditingController contactController = TextEditingController();
    // flutter defined function
    print(widget.doctor.name);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change contact"),
          content: new TextField(
              keyboardType: TextInputType.phone,
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'contact',
                icon: Icon(Icons.phone),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                FocusScope.of(context).unfocus();//close keyboard
                if (contactController.text.length < 5) {
                  Toast.show("Please enter correct contact number", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      return;
                }
                http.post(urlupdate, body: {
                  "email": widget.doctor.email,
                  "contact": contactController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.doctor.contact = dres[3];
                      Toast.show("Success.", context,
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

  void _changeOfficeContact() {
    TextEditingController officecontactController = TextEditingController();
    // flutter defined function
    print(widget.doctor.officecontact);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Office contact"),
          content: new TextField(
              keyboardType: TextInputType.phone,
              controller: officecontactController,
              decoration: InputDecoration(
                labelText: 'office contact',
                icon: Icon(Icons.phone),
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                if (officecontactController.text.length < 5) {
                  Toast.show("Please enter correct office contact number", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      return;
                }
                http.post(urlupdate, body: {
                  "email": widget.doctor.email,
                  "officecontact": officecontactController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    setState(() {
                      widget.doctor.officecontact = dres[5];
                      Toast.show("Success.", context,
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



