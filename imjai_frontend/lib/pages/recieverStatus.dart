import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';
import 'package:imjai_frontend/widget/orderStatusDetail.dart';

class recieverStatus extends StatefulWidget {
  const recieverStatus({super.key});

  @override
  State<recieverStatus> createState() => _recieverStatusState();
}

class _recieverStatusState extends State<recieverStatus> {
  double screenHeight = 0;
  double screenWidth = 0;
  CameraPosition? cameraPosition;
  late GoogleMapController mapController;
  int Number = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Number == 0
                          ? Container(
                              height: 500,
                              width: 600,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "Images/ReserveStatus/OrderTrackingImage.gif"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Number == 1
                              ? Container(
                                  height: 500,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "Images/ReserveStatus/Chicken.avif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Number == 2
                                  ? Container(
                                      width: 600,
                                      height: 500,
                                      child: Stack(
                                        children: [
                                          GoogleMap(
                                            onMapCreated: _onMapCreated,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(13.653137147646746,
                                                  100.49908711834206),
                                              zoom: 17,
                                            ),
                                            mapType: MapType.normal,
                                            onCameraMove: (CameraPosition
                                                cameraposition) {
                                              cameraPosition = cameraposition;
                                            },
                                          ),
                                          Center(
                                              //picker image on google map
                                              child: Icon(
                                            Icons.location_on_rounded,
                                            size: 40,
                                            color: Colors.orange,
                                          )),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 600,
                                      height: 500,
                                      child: Center(
                                        child: Icon(Icons.check_box_rounded),
                                      ),
                                    ),
                      Positioned(
                        top: 40,
                        left: 5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop((context));
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 35,
                            color: Color.fromARGB(255, 250, 122, 48),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 350),
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      Number++;
                                    });
                                  },
                                  child: Text("Click")),
                              OrderStatusDetail(),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
