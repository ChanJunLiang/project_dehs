import 'package:flutter/material.dart';
import 'package:dehs/mainscreen.dart';

class Appointment extends StatefulWidget {
    @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text('This will be notification', style: TextStyle(fontSize: 20)),
                ),
                
                
              ),

              SizedBox(
                height: 15,
              ),

              Container(
                padding: EdgeInsets.fromLTRB(15,5,15,5),
                color: Colors.teal[400],
                child: Center(
                child: Text("Your Appointment ",
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                 color: Colors.white)
                 ),),                            
                 ),
            ],
          ),

        ),
      );
  }

  
}
