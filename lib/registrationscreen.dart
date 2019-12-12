import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:dehs/patient.dart';
import 'package:dehs/loginscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dehs/mainscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

String pathAsset = 'assets/images/defaultpic.png';
String urlUpload = "http://pickupandlaundry.com/dehs/php/register.php";
File _image;
final TextEditingController _namecontroller = TextEditingController();
final TextEditingController _emcontroller = TextEditingController();
final TextEditingController _passcontroller = TextEditingController();
final TextEditingController _pass2controller = TextEditingController();
final TextEditingController _contactcontroller = TextEditingController();
String _name, _email, _password, _password2, _contact;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
  const RegisterScreen({Key key, File image}) : super(key: key);
}

class _RegisterUserState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('New User Registration'),
          backgroundColor: Colors.teal[200],
          
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: RegisterWidget(),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    _image = null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
    return Future.value(false);
  }
}

class RegisterWidget extends StatefulWidget {
  @override
  RegisterWidgetState createState() => RegisterWidgetState();
}

class RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
             onTap: () => mainBottomSheet(context),
            child: Container(
              width: 180,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _image == null
                        ? AssetImage(pathAsset)
                        : FileImage(_image),
                    fit: BoxFit.fill,
                  )),
            )),
        Text(_image == null
        ? 'Click on image above to change profile picture'
        : ' '),
        TextField(
            controller: _emcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              icon: Icon(Icons.email),
            )),
        TextField(
            controller: _namecontroller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Name',
              icon: Icon(Icons.person),
            )),
        TextField(
          controller: _passcontroller,
          decoration:
              InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),
          obscureText: true,
        ),
        TextField(
          controller: _pass2controller,
          decoration:
              InputDecoration(labelText: 'Re-enter Password', icon: Icon(Icons.lock)),
          obscureText: true,
        ),
        TextField(
            controller: _contactcontroller,
            keyboardType: TextInputType.phone,
            decoration:
                InputDecoration(labelText: 'Contact', icon: Icon(Icons.phone))),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          minWidth: 300,
          height: 50,
          child: Text('Register'),
          color: Colors.teal[200],
          textColor: Colors.black,
          elevation: 15,
          onPressed: _onRegister,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: _onBackPress,
            child: Text('Already Register', style: TextStyle(fontSize: 16))),
      ],
    );
  }

  void mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Camera', Icons.camera, _takephoto),
              _createTile(context, 'Gallery', Icons.photo_library, _choose),
            ],
          );
        });
  }  
    

    ListTile _createTile(
    BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  _takephoto() async {
    print('action camera');
    File _cameraImage;

    _cameraImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (_cameraImage != null) {
      //Avoid crash if user cancel picking image
      _image = _cameraImage;
      setState(() {});
    }
  }

  _choose() async {
    print('action gallery');
    File _galleryImage;

    _galleryImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_galleryImage != null) {
      //Avoid crash if user cancel picking image
      _image = _galleryImage;
      setState(() {});
    }
  }

  void _onRegister() {
    print('onRegister Button from RegisterUser()');
    print(_image.toString());
    uploadData();
  }

  void _onBackPress() {
    _image = null;
    Patient patient = new Patient(
          name: "not register",
          email: "user@noregister",
          phone: "not register",
          );
    print('onBackpress from RegisterUser');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => MainScreen(patient: patient)));
  }

  void uploadData() {
    _name = _namecontroller.text;
    _email = _emcontroller.text;
    _password = _passcontroller.text;
    _password2 = _pass2controller.text;
    _contact = _contactcontroller.text;

    if ((_isEmailValid(_email)) &&
        (_password.length > 5) &&
        (_image != null) &&
        (_contact.length > 5) &&
        (_password == _password2)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Registration in progress");
      pr.show();

      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(urlUpload, body: {
        "encoded_string": base64Image,
        "name": _name,
        "email": _email,
        "password": _password,
        "password2": _password2,
        "contact": _contact,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _image = null;
        _namecontroller.text = '';
        _emcontroller.text = '';
        _contactcontroller.text = '';
        _passcontroller.text = '';
        _pass2controller.text = '';
        pr.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
