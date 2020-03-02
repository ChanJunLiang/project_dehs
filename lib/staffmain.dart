import 'package:dehs/staff.dart';
import 'package:dehs/staffappointment.dart';
import 'package:dehs/staffappointment2.dart';
import 'package:flutter/material.dart';
import 'package:dehs/staffprofile.dart';

class StaffMain extends StatefulWidget {
  final Staff staff;
  const StaffMain({Key key,this.staff});
  
  @override
  _StaffMainState createState() => _StaffMainState();
}

class _StaffMainState extends State<StaffMain> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      StaffAppointment2(staff: widget.staff),
      StaffProfile(),
    ];
  }
  
  String $pagetitle = "Staff";

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
            icon: Icon(Icons.person ),
            title: Text("Staff Profile"),
          ),
        ],
      ),
      );
  }
  }
