import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/recieverStatus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
  final Uri phoneNumber = Uri.parse('tel:0970200803');

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
        print(category);
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
                Text("2.5 km", textAlign: TextAlign.center)
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
                  backgroundImage: AssetImage("Images/profile.jpg"),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        ownerName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 120),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: () async {
                            await FlutterPhoneDirectCaller.callNumber(
                                phone_number);
                          },
                          icon: const Icon(
                            Icons.phone,
                            size: 30,
                            color: Colors.orange,
                          ),
                        ),
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    title: const Text(
                      'Reserve',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                    content: const Text('Do you want to reserve?'),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => recieverStatus()));
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text(
              'Reserve',
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
