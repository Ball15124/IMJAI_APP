// @dart=2.9

import 'package:flutter/material.dart';
import 'package:imjai_frontend/pages/home.dart';
import 'package:imjai_frontend/pages/login.dart';
import 'package:imjai_frontend/pages/recieverStatus.dart';

import 'package:imjai_frontend/pages/register.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NavigationbarWidget());
  }
}
