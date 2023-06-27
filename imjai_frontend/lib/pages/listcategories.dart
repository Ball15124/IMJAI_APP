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
  Color primary = Color.fromARGB(255, 255, 255, 255);
  List<mainProduct> categoryList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final url = '/home/${widget.tag}';
      Response response = await Caller.dio.get(url);
      setState(() {
        print(response.data.runtimeType); // Print the type of response data
        print(response.data);

        if (response.data != null && response.data is List<dynamic>) {
          final List<dynamic> responseData = response.data;
          for (var product in responseData) {
            categoryList.add(mainProduct.fromJson(product));
          }
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
                    padding: EdgeInsets.only(top: 60, left: 10),
                    color: primary,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 4),
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
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text(
                              "Category: " + getCategoryName(widget.tag),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight / 35),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                        children: categoryList
                            .map((e) => ListOrder(
                                  id: e.id,
                                  title: e.name!,
                                  imageUrl: e.picture_url!,
                                  tag: e.category_id.toString(),
                                  range: "23 km",
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
