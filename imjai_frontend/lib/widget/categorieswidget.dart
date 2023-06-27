import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/widget/listcategoriesWidget.dart';

import '../model/mainproduct.dart';
import '../pages/caller.dart';
import '../pages/listcategories.dart';
import '../pages/product.dart';
import 'listProductwidget.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
   List<mainProduct> categoryproduct = [];
  @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   void fetchData() async {
//     try {
//       Future<List<dynamic>> fetchProductsByCategory(int categoryId) async {
//       final url = '/home/$categoryId'; // Replace with your actual backend API URL

//       final response = await Caller.dio.get(url);

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.data);
//         final List<dynamic> productListJson = jsonResponse as List<dynamic>;
//         setState(() {
//          final List<dynamic> CategoryRes = response.data;
//         for (var CategoryResponse in CategoryRes) {
//           categoryproduct.add(mainProduct.fromJson(CategoryResponse));
//         }
//         print(categoryproduct);
//         });
//         return productListJson;
        
//       } else {
//         throw Exception('Failed to fetch products');
//       }
// }
//     } catch (e) {
//       print(e);
//     }
//   }
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Categories(
            name: "Meat",
            imageUrl: "Meat",
            slug: "1",
          ),
          Categories(
            name: "Veget&Fruit",
            imageUrl: "Veget&Fruit",
            slug: "2",
          ),
          Categories(
            name: "Food",
            imageUrl: "Food",
            slug: "3",
          ),
          Categories(
            name: "Flavoring",
            imageUrl: "Flavoring",
            slug: "4",
          ),
          Categories(
            name: "Drink",
            imageUrl: "Drink",
            slug: "5",
          ),
          Categories(
            name: "Snack",
            imageUrl: "Snack",
            slug: "6",
          ),
          Categories(
            name: "Dessert",
            imageUrl: "Dessert",
            slug: "7",
          ),
          Categories(
            name: "Food Waste",
            imageUrl: "Food Waste",
            slug: "8",
          ),
        ],
      ),
    );
  }
  
}

class Categories extends StatelessWidget {
  String name;
  String imageUrl;
  String slug;

  Categories(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => ListCategoriesWidget(tag: 3),));
        navigateToProductList(context, slug);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child: Card(
              color: Colors.orange[50],
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: 64,
                height: 64,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Images/Categories/' + imageUrl + ".png",
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(height: 5),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 10.5,
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
  
  void navigateToProductList(BuildContext context, String slug) {
  int categoryId = getCategoryTag(slug);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ListCategories(tag: categoryId),
    ),
  );
}

  int getCategoryTag(String slug) {
    switch (slug) {
      case "1":
        return 1;
      case "2":
        return 2;
      case "3":
        return 3;
      case "4":
        return 4;
      case "5":
        return 5;
      case "6":
        return 6;
      case "7":
        return 7;
      case "8":
        return 8;
      default:
        return 0;
    }
  }
}
