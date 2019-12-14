import 'package:flutter/material.dart';
import 'package:dehs/appointment.dart';
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
      Appointment(),
      AdminProfile(),
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
            icon: Icon(Icons.list, ),
            title: Text("Appointment"),
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
