import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/widget/productDetail.dart';

class InsideProduct extends StatefulWidget {
  const InsideProduct({super.key});

  @override
  State<InsideProduct> createState() => _InsideProductState();
}

class _InsideProductState extends State<InsideProduct> {
  late int id;
  double screenHeight = 0;
  double screenWidth = 0;
  int productId = 0;
  String productName = '';
  String productPicture = '';
  String ownerName = '';
  String productDetail = '';
  String availableTime = '';
  String category = '';
  String locationLatitude = '';
  String locationLongtitude = '';
  Color primary = Color.fromARGB(255, 255, 255, 255);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData(context);
    });
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
        print(productName);
        productPicture = productData.picture_url!;
        print(productPicture);
        ownerName = productData.created_by_user!.firstname!;
        print(ownerName);
        productDetail = productData.description!;
        print(productDetail);
        availableTime = productData.available_time!;
        print(availableTime);
        category = productData.category_id.toString();
        print(category);
        productId = productData.id;
        locationLatitude = productData.location_latitude!;
        locationLongtitude = productData.location_longtitude!;
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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final routeArguments = ModalRoute.of(context)!.settings.arguments as int;
    final id = routeArguments;
    // final productId =
    //     routeArguments["productId"]; // test define productId to delete the post
    print("Id of product post " + id.toString());
    print('arguments');
    print(routeArguments);
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 60),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop((context));
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        title: const Text(
                                          'Delete',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange),
                                        ),
                                        content: const Text(
                                            'Do you want to delete this porduct?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              side: BorderSide(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.orange,
                                            ),
                                            onPressed: () async {
                                              // print(productId);
                                              await Caller.dio.delete(
                                                  "/products/$productId");
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(children: [
                        Container(
                          height: 300,
                          width: 600,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("Images/Food/wagyu.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  ProductDetail(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
