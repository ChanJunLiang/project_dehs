import 'package:flutter/material.dart';
import 'package:dehs/loginscreen.dart';
import 'package:http/http.dart'as http;


void main() => runApp(SplashScreen());
String url = "http://pickupandlaundry.com/dehs/login.php";

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/dehslogoo.jpeg',
                scale: 2,
              ),
              SizedBox(
                height: 20,
              ),
              new ProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
   super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      width: 200,
      color: Colors.black,
      child: LinearProgressIndicator(
        value: animation.value,
        backgroundColor: Colors.teal,
        valueColor:
            new AlwaysStoppedAnimation<Color>(Colors.tealAccent),
      ),
    ));
  }
}


Map<int, Color> color = {
  50: Color.fromRGBO(255, 185, 43, .1),
  100: Color.fromRGBO(255, 185, 43, .2),
  200: Color.fromRGBO(255, 185, 43, .3),
  300: Color.fromRGBO(255, 185, 43, .4),
  400: Color.fromRGBO(255, 185, 43, .5),
  500: Color.fromRGBO(255, 185, 43, .6),
  600: Color.fromRGBO(255, 185, 43, .7),
  700: Color.fromRGBO(255, 185, 43, .8),
  800: Color.fromRGBO(255, 185, 43, .9),
  900: Color.fromRGBO(159, 30, 99, 1),
};
