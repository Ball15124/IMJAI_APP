import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/giverStatus.dart';
import 'package:imjai_frontend/widget/giverStatusDetail.dart';

import '../pages/caller.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late int id;
  double screenHeight = 0;
  double screenWidth = 0;
  String productName = '';
  String productPicture = '';
  String ownerName = '';
  String productDetail = '';
  String availableTime = '';
  String category = '';
  String locationLatitude = '';
  String locationLongtitude = '';
  String phone_number = '';
  String ownerPicture = '';

  String receiverLatitude = '';
  String receiverLongtitude = '';
  int status = 0;
  int productId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData(context);
    });
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

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

  void fetchData(BuildContext context) async {
    try {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      Response response = await Caller.dio.get("/products/products/$id");
      print(response.data);
      setState(() {
        print(1);
        final productData = mainProduct.fromJson(response.data["product"]);
        print(productData);
        productName = productData.name!;
        productId = productData.id;
        phone_number = productData.created_by_user!.phone_number!;
        print(phone_number);
        print(productName);
        productPicture = productData.picture_url!;
        print(productPicture);
        ownerName = productData.created_by_user!.firstname! +
            " " +
            productData.created_by_user!.lastname!;
        print(ownerName);
        productDetail = productData.description!;
        print(productDetail);
        availableTime = productData.available_time!;
        print(availableTime);
        category = productData.category_id.toString();
        ownerPicture = productData.created_by_user!.profile_url!;
        print(category);
        status = productData.status!;
        locationLatitude = productData.location_latitude!;
        locationLongtitude = productData.location_longtitude!;
        receiverLatitude =
            productData.reserved!.reserved_users!.location_latitude!;
        receiverLongtitude =
            productData.reserved!.reserved_users!.location_longtitude!;
        print(" reciever Latitude " + receiverLatitude);
        // Map<String, dynamic> productInfo = response.data;
        // print(55555555);
        // print(productInfo);
        // print(2);
        // print('awdwadwad');
      });
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    if (this.category == "1") {
      category = "Meat";
    } else if (this.category == "2") {
      // Handle other cases if needed
      category = "Vegetable & Fruit";
    } else if (this.category == "3") {
      // Handle other cases if needed
      category = "Food";
    } else if (this.category == "4") {
      // Handle other cases if needed
      category = "Flavoring";
    } else if (this.category == "5") {
      // Handle other cases if needed
      category = "Drink";
    } else if (this.category == "6") {
      // Handle other cases if needed
      category = "Snack";
    } else if (this.category == "7") {
      // Handle other cases if needed
      category = "Dessert";
    } else if (this.category == "8") {
      // Handle other cases if needed
      category = "Food Waste";
    } else {
      category = "No Categories";
    }

    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                productName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Categories",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "Range",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  availableTime,
                  textAlign: TextAlign.center,
                ),
                Text(category, textAlign: TextAlign.center),
                Text(
                    status >= 1
                        ? calculateDistance(
                            double.parse(locationLatitude),
                            double.parse(locationLongtitude),
                            double.parse(receiverLatitude),
                            double.parse(receiverLongtitude))
                        : "Waiting for \n reserve",
                    textAlign: TextAlign.center)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Detail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productDetail,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Giver",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(ownerPicture),
                ),
                Container(
                  width: 190,
                  padding: EdgeInsets.only(left: 10),
                  child: Wrap(
                    children: [
                      Text(
                        ownerName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              side: const BorderSide(color: Colors.orange, width: 2),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              if (status == 0) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Reciever not found!'),
                      content: const Text(
                          'No receiver yet , Please wait for reservation'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => giverStatus()),
                        settings: RouteSettings(arguments: productId)));
              }
            },
            child: const Text(
              'Check Order',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
