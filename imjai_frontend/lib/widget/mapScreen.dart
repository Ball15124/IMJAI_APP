import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String googleApikey = "AIzaSyDjP50OxuzlO0kIb6eAh3CKxEe0bDKho0A";
  late GoogleMapController? mapController; //contrller for Google map
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Location Name:";
  String locationAd = "Address:";
  CameraPosition? cameraPosition;
  LatLng? _currentPosition;
  String finalLatitude = "";
  String finalLongtitude = "";
  String location_Name = "";
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      print(_currentPosition);
      _isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  zoomGesturesEnabled: true,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 15,
                  ),
                  mapType: MapType.normal, //map type
                  onCameraMove: (CameraPosition cameraPositiona) {
                    cameraPosition = cameraPositiona; //when map is dragging
                  },
                  onCameraIdle: () async {
                    //when map drag stops
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude,
                    );
                    setState(() {
                      //get place name from lat and lang
                      location = placemarks.first.name.toString();
                      locationAd =
                          placemarks.first.administrativeArea.toString() +
                              ", " +
                              placemarks.first.street.toString() +
                              ", " +
                              placemarks.first.country.toString();
                      location_Name = placemarks.first.name.toString();
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
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  backgroundColor: Colors.orange,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width / 3,
                                      40)),
                              onPressed: () async {
                                print(
                                    cameraPosition!.target.latitude.toString() +
                                        ", " +
                                        cameraPosition!.target.longitude
                                            .toString());
                                SharedPreferences productLocation =
                                    await SharedPreferences.getInstance();

                                setState(() {
                                  finalLatitude = cameraPosition!
                                      .target.latitude
                                      .toString();
                                  finalLongtitude = cameraPosition!
                                      .target.longitude
                                      .toString();
                                  productLocation.setString(
                                      'productLatitude', finalLatitude);
                                  productLocation.setString(
                                      'productLongtitude', finalLongtitude);
                                  productLocation.setString(
                                      'productLocation', locationAd);
                                  print("This is your final location " +
                                      finalLatitude +
                                      ", " +
                                      finalLongtitude);
                                  print("This is your location name " +
                                      location_Name);
                                  Navigator.pop(context, locationAd);
                                  // String testLati = productLatitude
                                  //     .getString('productLatitude')!;
                                  // print(testLati);
                                  // Navigator.pop(context);
                                });
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
