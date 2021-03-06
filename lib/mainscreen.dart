import 'package:dehs/makeappointment1.dart';
import 'package:dehs/patientappt.dart';
import 'package:flutter/material.dart';
import 'package:dehs/appointment.dart';
import 'package:dehs/patientprofile.dart';
import 'package:dehs/patient.dart';

class MainScreen extends StatefulWidget {
  final Patient patient;
 

  const MainScreen({Key key,this.patient}) : super(key: key);

  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      MakeAppointment1(patient: widget.patient),
      Patientappt(patient: widget.patient),
      PatientProfile(patient: widget.patient),
    ];
  }
  
  String $pagetitle = "DEHS";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        backgroundColor: Colors.teal[50],
        type: BottomNavigationBarType.fixed,

        items: [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Appointment"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person ),
            title: Text("Your Appointment"),
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person ),
            title: Text("Patient Profile"),
          ),
        ],
      ),
      );
  }
  }
