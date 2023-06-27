import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';

class InsideOrder extends StatefulWidget {
  const InsideOrder({super.key});

  @override
  State<InsideOrder> createState() => _InsideOrderState();
}

class _InsideOrderState extends State<InsideOrder> {
  late int id;
  int productId = 0;
  String productName = '';
  String productPicture = '';
  String ownerName = '';
  String productDetail = '';
  String availableTime = '';
  String category = '';
  String locationLatitude = '';
  String locationLongtitude = '';
  double screenHeight = 0;
  double screenWidth = 0;
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
                    padding: EdgeInsets.only(top: 60),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: [
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
                                ],
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
                              image: NetworkImage(productPicture),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  OrderDetail()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
