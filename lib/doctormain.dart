import 'package:dehs/doctor.dart';
import 'package:dehs/doctorannounce.dart';
import 'package:dehs/doctorappointment2.dart';
import 'package:flutter/material.dart';
import 'package:dehs/doctorprofile.dart';

class DoctorMain extends StatefulWidget {
  final Doctor doctor;
  const DoctorMain({Key key,this.doctor});
  
  @override
  _DoctorMainState createState() => _DoctorMainState();
}

class _DoctorMainState extends State<DoctorMain> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      DoctorAppointment2(doctor: widget.doctor),
      Doctorannouncement(doctor: widget.doctor),
      DoctorProfile(doctor: widget.doctor),
    ];
  }
  
  String $pagetitle = "Doctor";

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
            icon: Icon(Icons.list ),
            title: Text("Appointment List"),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.mail ),
            title: Text("Announcement"),
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person ),
            title: Text("Doctor Profile"),
          ),
        ],
      ),
      );
  }
  }
