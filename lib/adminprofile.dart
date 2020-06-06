import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:dehs/admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:dehs/main.dart';

String urlupdate = "http://pickupandlaundry.com/dehs/php/doctorupdateprofile.php";
int number = 0;

class AdminProfile extends StatefulWidget {
  final Admin admin;

  AdminProfile({Key key, this.admin}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
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
                                      fontSize: 18),),
                                  new Text(('ADMIN'),style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  ]),

                                  TableRow(children: [
                                  Container(height: 18,),
                                  Container(height: 18,),
                                  ]),

                                  TableRow(children: [
                                  new Text("Email",style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
                                  new Text(widget.admin.email,style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),),
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
          title: new Text("Change " + widget.admin.name),
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
                  "email": widget.admin.email,
                  "name": nameController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.admin.name = dres[1];
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
                  "email": widget.admin.email,
                  "password": passController.text,
                }).then((res) {
                  var string = res.body;
                  List dres = string.split(",");
                  if (dres[0] == "success") {
                    print('in success');
                    setState(() {
                      widget.admin.name = dres[1];
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

  


  void savepref(String pass) async {
    print('Inside savepref');
    SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('pass', pass);
  }
    
}



