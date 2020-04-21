import 'package:dehs/admin.dart';
import 'package:dehs/doctorforgot.dart';
import 'package:dehs/forgotpassword.dart';
import 'package:dehs/doctor.dart';
import 'package:dehs/doctormain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dehs/mainscreen.dart';
import 'package:dehs/registrationscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dehs/patient.dart';
import 'package:dehs/adminmain.dart';


String urlLogin = "http://pickupandlaundry.com/dehs/php/login.php";
String urlLoginDoctor = "http://pickupandlaundry.com/dehs/php/doctorlogin.php";
String urlLoginAdmin= "http://pickupandlaundry.com/dehs/php/loginadmin.php";
String urlSecurityCodeForResetPass ='https://pickupandlaundry.com/dehs/php/securitycode.php';
String urlSecurityCodeForResetPassDr ='https://pickupandlaundry.com/dehs/php/doctorsecuritycode.php';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  final TextEditingController _passcontroller = TextEditingController();
  String _password = "";
  bool _isChecked = false;
  var _user = ['User','Doctor','Admin'];
  var _currentuser = 'User';

  @override
  void initState() {

    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
          backgroundColor: Colors.teal[200],
          title: Text('Log In'),
        ),
          resizeToAvoidBottomPadding: true,
          body: SingleChildScrollView(
                      child: new Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.0, color: Colors.teal[300]),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/dehslogo.jpeg'))
                      ),
                    
                  ),
                  
                  Center(
                    
                    child:Container(
                      height: 40,
                      width: 75,
                      child: DropdownButton<String>(
                        items: _user.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                        value: _currentuser,
                      ),
                      )),

   

                  TextField(
                      controller: _emcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email', icon: Icon(Icons.email))),
                  TextField(
                    controller: _passcontroller,
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minWidth: 300,
                    height: 50,
                    child: Text('Login'),
                    color: Colors.teal[200],
                    textColor: Colors.black,
                    elevation: 15,
                    onPressed: _onLogin,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  
                  GestureDetector(
                      onTap: _onRegister,
                      child: Text('Register New Account',
                          style: TextStyle(fontSize: 16))),
                  SizedBox(
                    height: 10,
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: _onForgot,
                      child:
                          Text('Forgot Account', style: TextStyle(fontSize: 16))),
                ],
              ),
            ),
          ),
        );
  }
    
    void _onLogin(){
      _email = _emcontroller.text;
    _password = _passcontroller.text;
    if (_isEmailValid(_email) && (_password.length > 4) && this._currentuser == 'User') {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in");
      pr.show();
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
         var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "success") {
           pr.dismiss();
           print(dres);
          Patient patient = new Patient(name:dres[1],email: dres[2],contact:dres[3],icno:dres[4],address:dres[5],em_contact:dres[4]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(patient: patient)));
        } else {
          pr.dismiss();
          
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else if(_email==null||_password==null){
      Toast.show("Log in failed, please try again.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      }else if(_isEmailValid(_email) && (_password.length > 4) && this._currentuser =='Doctor'){
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in Doctor");
      pr.show();
      http.post(urlLoginDoctor, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
         var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "success") {
          print("success doctor");
          pr.dismiss();
          print(dres);
         Doctor doctor = new Doctor(name:dres[1],email: dres[2], drid:dres[3], icno:dres[4], contact:dres[5],officecontact:dres[6], address:dres[7]
         , t0910:dres[8], t0930:dres[9], t0950:dres[10], t1010:dres[11], t1030:dres[12], t1050:dres[13], t1110:dres[14], t1130:dres[15], t1150:dres[16]
         , t1410:dres[17], t1430:dres[18], t1450:dres[19], t1510:dres[20], t1530:dres[21], t1550:dres[22], t1610:dres[23], t1630:dres[24]);
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorMain(doctor: doctor)));
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });          
    } else if(_isEmailValid(_email) && (_password.length > 4) && this._currentuser == 'Admin'){
       ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in Admin");
      pr.show();
      http.post(urlLoginAdmin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
         var string = res.body;
        List dres = string.split(",");
        print(dres);
        Toast.show(dres[0], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (dres[0] == "success") {
          print("success admin");
          pr.dismiss();
          print(dres);
         Admin admin = new Admin(name:dres[1],email: dres[2],contact:dres[3]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminMain(admin: admin)));
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    }else{}
  }

     void _onForgot(){
    _email = _emcontroller.text;

    if (_isEmailValid(_email)&& this._currentuser == 'User') {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Sending Email");
      pr.show();
      http.post(urlSecurityCodeForResetPass, body: {
        "email": _email,
      }).then((res) {
        print("secure code : " + res.body);
        if (res.body == "error") {
          pr.dismiss();
          Toast.show('error', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        } else {
          pr.dismiss();
          _saveEmailForPassReset(_email);
          _saveSecureCode(res.body); 
          Toast.show('Security code sent to your email', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgotPassword()));
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else if(_isEmailValid(_email)&& this._currentuser == 'Doctor') {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Sending Email");
      pr.show();
      http.post(urlSecurityCodeForResetPassDr, body: {
        "email": _email,
      }).then((res) {
        print("secure code : " + res.body);
        if (res.body == "error") {
          pr.dismiss();
          Toast.show('error', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        } else {
          pr.dismiss();
          _saveEmailForPassReset(_email);
          _saveSecureCode(res.body); 
          Toast.show('Security code sent to your email', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DoctorForgot()));
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {
      Toast.show('Invalid Email', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }
  
  void _saveEmailForPassReset(String email) async {
    print('saving preferences');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('resetPassEmail', email);
  }

  void _saveSecureCode(String code) async {
    print('saving preferences');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('secureCode', code);
  }

    void _onRegister(){
    print('onRegister');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    }
   


  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    _password = (prefs.getString('pass'));
    print(_email);
    print(_password);
    if (_email.length > 1) {
      _emcontroller.text = _email;
      _passcontroller.text = _password;
      setState(() {
        _isChecked = true;
      });
    } else {
      print('No pref');
      setState(() {
        _isChecked = false;
      });
    }
  }

  void savepref(bool value) async {
    print('Inside savepref');
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //true save pref
      if (_isEmailValid(_email) && (_password.length > 5)) {
        await prefs.setString('email', _email);
        await prefs.setString('pass', _password);
        print('Save pref $_email');
        print('Save pref $_password');
        Toast.show("Preferences have been saved", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print('No email');
        setState(() {
          _isChecked = false;
        });
        Toast.show("Check your credentials", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emcontroller.text = '';
        _passcontroller.text = '';
        _isChecked = false;
      });
      print('Remove pref');
      Toast.show("Preferences have been removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentuser = newValueSelected;
    });
  }  


  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  
}
