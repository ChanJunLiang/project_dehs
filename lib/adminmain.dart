import 'package:dehs/listdoctorprofile.dart';
import 'package:dehs/listpatientprofile.dart';
import 'package:flutter/material.dart';
import 'package:dehs/adminprofile.dart';
import 'package:dehs/admin.dart';
class AdminMain extends StatefulWidget {
  final Admin admin;
  const AdminMain({Key key,this.admin});

  
  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      ListPatientProfile(admin: widget.admin),
      ListDoctorProfile(admin: widget.admin),
      AdminProfile(admin: widget.admin),
    ];
  }
  
  String $pagetitle = "Admin";

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
            icon: Icon(Icons.face, ),
            title: Text("Patient"),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account, ),
              title: Text("Doctor"),
            ), 
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person ),
            title: Text("Admin Profile"),
          ),
        ],
      ),
      );
  }
  }
