import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/createproduct.dart';
import 'package:imjai_frontend/widget/listProductwidget.dart';
import 'package:imjai_frontend/widget/listreservewidget.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Color.fromARGB(255, 255, 255, 255);
  List<mainProduct> list_product = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await Caller.dio.get("/products/getproducts");
      setState(() {
        print(response.data);
        final List<dynamic> products = response.data["created_products"];
        for (var product in products) {
          print(products);
          list_product.add(mainProduct.fromJson(product));
        }
        print(list_product);
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
                    padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "My Product",
                            style: TextStyle(
                                fontSize: screenWidth / 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: screenHeight / 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Product List",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 20),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Createproduct()));
                              },
                              icon: const Icon(
                                Icons.add_circle_rounded,
                                size: 35,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        //SizedBox(height: screenHeight / 50),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: list_product.map((e) {
                              String ownerName;
                              if (e.reserved != null &&
                                  e.reserved!.reserved_users != null &&
                                  e.reserved!.reserved_users!.firstname !=
                                      null &&
                                  e.reserved!.reserved_users!.firstname!
                                      .isNotEmpty) {
                                ownerName =
                                    e.reserved!.reserved_users!.firstname! +
                                        " " +
                                        e.reserved!.reserved_users!.lastname!;
                              } else {
                                ownerName = "No reserver";
                              }

                              return ProductList(
                                  id: e.id,
                                  title: e.name!,
                                  imageUrl: e.picture_url!,
                                  tag: e.category_id.toString(),
                                  owner: ownerName,
                                  status: e.status.toString());
                            }).toList(),
                          ),
                        )
                        // ProductList(title: title, imageUrl: imageUrl, tag: tag, range: range, owner: owner, status: status)
                        // ListProductWidget(),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
