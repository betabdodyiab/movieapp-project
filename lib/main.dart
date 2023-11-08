import 'package:flutter/material.dart';
import 'package:movies_app/HomeScreen.dart';

import 'Browse.dart';
import 'DetailsMovie.dart';
import 'SearchScreen.dart';
import 'SplashScreen.dart';
import 'WatchList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primaryColor: Colors.black,
        iconTheme:IconThemeData(
            color:Colors.white
        ) ,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          //backgroundColor: Colors.black,
          // backgroundColor: Color(0xFFB7935F),
            selectedItemColor: Colors.yellow,
            unselectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
                size:32
            )
        ),
        useMaterial3: true,
      ),
      routes: {
        SplashScreen.routeName: (_)=>SplashScreen(),
        HomeScreen.routeName: (_)=>HomeScreen(),
        SearchScreen.routeName: (_)=>SearchScreen(),
        Browse.routeName: (_)=>Browse(),
        WatchList.routeName: (_)=>WatchList(),
       // DetailsMovie.routeName: (_)=>DetailsMovie(),


      },
      initialRoute: SplashScreen.routeName,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

