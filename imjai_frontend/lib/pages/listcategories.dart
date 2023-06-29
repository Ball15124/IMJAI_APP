import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/widget/listcategoriesWidget.dart';
import 'package:imjai_frontend/widget/listorderwidget.dart';

import 'caller.dart';

class ListCategories extends StatefulWidget {
  final int tag;
  const ListCategories({super.key, required this.tag});

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  double screenHeight = 0;
  double screenWidth = 0;
  String locationLat = '';
  String locationLong = '';
  Color primary = Color.fromARGB(255, 255, 255, 255);
  List<mainProduct> categoryList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers

    double lat1Radians = degreesToRadians(lat1);
    double lon1Radians = degreesToRadians(lon1);
    double lat2Radians = degreesToRadians(lat2);
    double lon2Radians = degreesToRadians(lon2);

    double latDiff = lat2Radians - lat1Radians;
    double lonDiff = lon2Radians - lon1Radians;
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

  void fetchData() async {
    try {
      final url = '/home/${widget.tag}';
      Response response = await Caller.dio.get(url);
      Response locationRes = await Caller.dio.get("/home/location");

      setState(() {
        print(response.data.runtimeType); // Print the type of response data
        print(response.data);

        if (response.data != null && response.data is List<dynamic>) {
          final List<dynamic> responseData = response.data;
          for (var product in responseData) {
            categoryList.add(mainProduct.fromJson(product));
          }
          Map<String, dynamic> fetchLocation = locationRes.data;
          locationLat = fetchLocation['location_latitude'];
          locationLong = fetchLocation['location_longtitude'];
        } else {
          print("Invalid response data format");
        }
      });
    } catch (e) {
      print(e);
    }
  }

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
                    padding: EdgeInsets.only(top: 60, left: 20),
                    color: primary,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop((context));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      getCategoryName(widget.tag),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 35),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                        children: categoryList
                            .map((e) => ListOrder(
                                  id: e.id,
                                  title: e.name!,
                                  imageUrl: e.picture_url!,
                                  tag: e.category_id.toString(),
                                  range: calculateDistance(
                                    double.parse(locationLat),
                                    double.parse(locationLong),
                                    double.parse(e.location_latitude!),
                                    double.parse(e.location_longtitude!),
                                  ),
                                  owner: e.created_by_user!.firstname! +
                                      " " +
                                      e.created_by_user!.lastname!,
                                ))
                            .toList()),
                  )
                  // ListCategoriesWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getCategoryName(int tag) {
    switch (tag) {
      case 1:
        return "Meat";
      case 2:
        return "Vegetable & Fruit";
      case 3:
        return "Food";
      case 4:
        return "Flavoring";
      case 5:
        return "Drink";
      case 6:
        return "Snack";
      case 7:
        return "Dessert";
      case 8:
        return "Food Waste";
      default:
        return "No Categories";
    }
  }
}
