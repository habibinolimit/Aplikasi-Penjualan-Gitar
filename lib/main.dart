import 'package:flutter/material.dart';
import 'package:uaspm/bottomnav.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNav(),
    );
  }
}