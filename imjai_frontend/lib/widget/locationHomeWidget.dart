import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/mapScreen.dart';
import 'package:imjai_frontend/widget/mapScreenHome.dart';

class LocationHomeWidget extends StatefulWidget {
  const LocationHomeWidget({super.key});

  @override
  State<LocationHomeWidget> createState() => _LocationHomeWidgetState();
}

class _LocationHomeWidgetState extends State<LocationHomeWidget> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 630,
            width: 450,
            child: MapScreenHome(),
          ),
        ],
      ),
    );
  }
}
