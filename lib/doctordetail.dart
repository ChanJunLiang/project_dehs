import 'dart:async';
import 'package:dehs/adminmain.dart';
import 'package:dehs/makeappointment1.dart';
import 'package:dehs/doctor.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'dart:convert';

List data;

class DoctorDetail extends StatefulWidget {
  final Doctor doctor;

  const DoctorDetail({Key key, this.doctor}) : super(key: key);

  @override
  _DoctorDetailState createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.tealAccent));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold( 
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.teal[100],
          appBar: AppBar(
            title: Text('DOCTOR DETAILS'),
            backgroundColor: Colors.teal[300],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                doctor: widget.doctor,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => AdminMain(),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final Doctor doctor;
  DetailInterface({this.doctor});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  @override
  void initState() {
    super.initState();
    // print(advertiser.name);
    print('here is detail');
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text('Dr. ' +widget.doctor.name.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Container(
            child: Column(
              
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.teal[100],
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(1.0),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                  TableRow(children: [
                    Text("Doctor ID",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.drid,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Doctor Email",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.email,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("IC Number",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.icno,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Contact Number",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.contact,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Emergency Contact",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.officecontact,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                  TableRow(children: [
                    Text("Address",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text(widget.doctor.address,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
                  ]),
                  TableRow(children: [
                    SizedBox(
                        height: 10,
                      ),SizedBox(
                        height: 10,
                      ),
                  ]),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              
              Container(
                width: 350,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 40,
                  child: Text(
                    'Delete account',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.teal[400],
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: (){
                    _onDelete(widget.doctor.email);
                  }
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
  void _onDelete(email) {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete " + widget.doctor.name),
          content: new Text("Are your sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                deleteRequest(widget.doctor.email);
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

  Future<String> deleteRequest(String email) async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/deletedoctor.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Deleting Account");
    pr.show();
    http.post(urlLoadJobs, body: {
      "email": email,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        init();
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

  Future init() async {
    this.makeRequest();
  }

  Future<String> makeRequest() async {
    String urlLoadJobs = "http://pickupandlaundry.com/dehs/php/listdoctors.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading Doctor");
    pr.show();
    http.post(urlLoadJobs, body: {
      "email": widget.doctor.email ?? "notavailable",
    }).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        data = extractdata["doctors"];
        perpage = (data.length / 10);
        print("data");
        print(data);
        pr.dismiss();
      });
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }
}