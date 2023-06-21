import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'mapScreen.dart';

class LocationProductWidget extends StatefulWidget {
  const LocationProductWidget({super.key});

  @override
  State<LocationProductWidget> createState() => _LocationProductWidgetState();
}

class _LocationProductWidgetState extends State<LocationProductWidget> {
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
            child: MapScreen(),
          ),
        ],
      ),
    );
  }
}
