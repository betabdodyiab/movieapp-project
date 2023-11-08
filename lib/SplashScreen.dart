

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_app/HomeScreen.dart';



class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              scale: 1.5,
                image: AssetImage('assets/images/img.png',),

              //fit: BoxFit.cover,
            ),
    ),
       // child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}

