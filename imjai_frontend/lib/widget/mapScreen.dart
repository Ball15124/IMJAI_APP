import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imjai_frontend/widget/locations.dart' as locations;
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String googleApikey = "AIzaSyDjP50OxuzlO0kIb6eAh3CKxEe0bDKho0A";
  GoogleMapController? mapController; //contrller for Google map
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Location Name:";
  String locationAd = "Address:";
  CameraPosition? cameraPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          zoomGesturesEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(13.651229681351824, 100.49574871158195),
            zoom: 15,
          ),
          mapType: MapType.normal, //map type
          onMapCreated: (controller) {
            //method called when map is created
            setState(() {
              mapController = controller;
            });
          },
          onCameraMove: (CameraPosition cameraPositiona) {
            cameraPosition = cameraPositiona; //when map is dragging
          },
          onCameraIdle: () async {
            //when map drag stops
            List<Placemark> placemarks = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude);
            setState(() {
              //get place name from lat and lang
              location = placemarks.first.name.toString();
              locationAd = placemarks.first.administrativeArea.toString() +
                  ", " +
                  placemarks.first.street.toString() +
                  ", " +
                  placemarks.first.country.toString();
            });
          },
        ),
        Center(
            //picker image on google map
            child: Icon(
          Icons.location_on_rounded,
          size: 40,
          color: Colors.orange,
        )),
        Positioned(
            //widget to display location name
            bottom: 80,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Card(
                child: Container(
                    height: 150,
                    padding: EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width - 80,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.location_on_rounded,
                            size: 30,
                            color: Colors.orange,
                          ),
                          title: Text(
                            locationAd,
                            style: TextStyle(fontSize: 18),
                          ),
                          dense: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                backgroundColor: Colors.orange,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width / 3, 40)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog();
                                  });
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(),
                            ))
                      ],
                    )),
              ),
            ))
      ]),
    );
  }
}
