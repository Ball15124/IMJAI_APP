// import 'dart:ffi';

//import 'dart:html';

import 'package:dio/dio.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
// import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/model/me.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/location.dart' as locationPage;
import 'package:imjai_frontend/pages/locationHome.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/categorieswidget.dart';
import 'package:imjai_frontend/widget/listorderwidget.dart';
import 'dart:math';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/searchwidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<mainProduct> mainproduct = [];
  String phone_number = '';
  String fname = '';
  String lastname = '';
  String email = '';
  String profileUrl = '';
  String birthdate = '';
  String? location;
  String locationLat = '';
  String locationLong = '';
  double doubleLat = 0;
  double doubleLong = 0;
  String setlocation_name = '';
  String setlocation_street = '';
  final TextEditingController _searchController = TextEditingController();
  List<mainProduct> filteredList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    // Convert latitude and longitude to radians
    double lat1Radians = degreesToRadians(lat1);
    double lon1Radians = degreesToRadians(lon1);
    double lat2Radians = degreesToRadians(lat2);
    double lon2Radians = degreesToRadians(lon2);

    // Calculate the differences between coordinates
    double latDiff = lat2Radians - lat1Radians;
    double lonDiff = lon2Radians - lon1Radians;

    // Calculate the Haversine formula
    double a = pow(sin(latDiff / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    String formattedDistance = distance.toStringAsFixed(2);

    return formattedDistance + ' km';
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  getLocation() async {
    Response locationRes = await Caller.dio.get("/home/location");
    Map<String, dynamic> fetchLocation = locationRes.data;
    locationLat = fetchLocation['location_latitude'];
    locationLong = fetchLocation['location_longtitude'];
    print(locationLat);
    print(locationLong);

    doubleLat = double.parse(locationLat);
    doubleLong = double.parse(locationLong);
    print(doubleLat);
    print(doubleLong);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(doubleLat, doubleLong);

    setlocation_street = placemarks.first.administrativeArea.toString() +
        ", " +
        placemarks.first.street.toString() +
        ", " +
        placemarks.first.country.toString();
    setlocation_name = placemarks.first.name.toString();
    print(setlocation_street);
    print(setlocation_name);
    // location_name = setlocation_name;
  }

  void filterList(String query) async {
    // Response productResponse = await Caller.dio.get("/home/list");
    setState(() {
      if (query.isNotEmpty) {
        filteredList = mainproduct
            .where((e) => e.name.toString().contains(query))
            .toList();
      } else {
        filteredList = List<mainProduct>.from(mainproduct);
        // final List<dynamic> productRes = productResponse.data;
        // for (var productResponse in productRes) {
        //   filteredList.add(mainProduct.fromJson(productResponse));
        // }
      }
    });
  }

  void fetchData() async {
    try {
      Response response = await Caller.dio.get("/home/me");
      Response productResponse = await Caller.dio.get("/home/list");

      await getLocation();
      // Response listResponse = await Caller.dio.get("/list");
      setState(() {
        print("111");
        print(response.data);
        // print(locationRes.data);
        final data = meProfile.fromJson(response.data);

        print("222");
        fname = data.firstname!;
        lastname = data.lastname!;
        email = data.email!;

        print(email);
        phone_number = data.phone_number!;
        print(phone_number);
        birthdate = data.birthdate!;
        print(birthdate);
        this.profileUrl = data.profile_url!;
        print(data.firstname);

        print("place");

        print(setlocation_name);
        print(setlocation_street);

        final List<dynamic> productRes = productResponse.data;
        for (var productResponse in productRes) {
          mainproduct.add(mainProduct.fromJson(productResponse));
        }
        print(mainproduct);
        filteredList = List<mainProduct>.from(mainproduct);
      });
    } catch (e) {
      print(e);
    }
  }

  var currentIndex = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);

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
                  Container(
                    padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Welcome 👋🏻",
                                  style: TextStyle(
                                      color: Colors.blueGrey[400],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  fname + " " + lastname,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Profile()));
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(profileUrl),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 45),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            backgroundColor: Colors.orange,
                            minimumSize: Size(screenWidth - 30, 50),
                          ),
                          icon: const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          label: Text(
                            setlocation_name,
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationHome()));
                          },
                        ),
                        SizedBox(height: screenHeight / 65),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (value) => filterList(value),
                            decoration: InputDecoration(
                              hintText: 'Search for your interest',
                              prefixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Categories",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        CategoriesWidget(),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "List",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(
                              children: filteredList.map((e) {
                                return ListOrder(
                                  id: e.id,
                                  title: e.name!,
                                  imageUrl: e.picture_url!,
                                  tag: e.category_id.toString(),
                                  owner: e.created_by_user!.firstname! +
                                      " " +
                                      e.created_by_user!.lastname!,
                                  range: calculateDistance(
                                    doubleLat,
                                    doubleLong,
                                    double.parse(e.location_latitude!),
                                    double.parse(e.location_longtitude!),
                                  ).toString(),
                                );
                              }).toList(),
                            ))
                        //ListOrderWidget(),
                      ],
                    ),
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
