import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dehs/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dehs/splashscreen.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

String urlgetdriver = "http://pickupandlaundry.com/my_pickup/chan/php/getdriver.php";
String urluploadImage =
    "http://pickupandlaundry.com/my_pickup/chan/php/upload_imageprofile.php";
String urlupdate = "http://pickupandlaundry.com/my_pickup/chan/php/user.php";
File _image;
int number = 0;
String _value;

class AdminProfile extends StatefulWidget {

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
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
           appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text('Profile', style: TextStyle(color:Colors.white)),
        ),
          body: ListView.builder(
              //Step 6: Count the data
              itemCount: 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                         
                          Column(
                            children: <Widget>[
                              Center(
                                child: Text("DEHS",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              
                            ],
                          ),
                        ]),
                        SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  );
                }

                if (index == 1) {
                  return Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Column(
                      children: <Widget>[
                        MaterialButton(
                          onPressed: _logout,
                          child: Text("LOG OUT"),
                        )
                      ],
                    ),
                  );
                }
              }),
        ));
  }

  


  void _logout() async {
    print("LOGOUT");
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

}



