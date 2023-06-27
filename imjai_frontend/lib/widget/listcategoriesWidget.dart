import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/mainproduct.dart';
import '../pages/InsideOrder.dart';
import '../pages/caller.dart';

class ListCategoriesWidget extends StatefulWidget {
  final int tag;
  const ListCategoriesWidget({super.key, required this.tag});

  @override
  State<ListCategoriesWidget> createState() => _ListCategoriesWidgetState();
}

class _ListCategoriesWidgetState extends State<ListCategoriesWidget> {
  double screenHeight = 0;
  double screenWidth = 0;
  List<mainProduct> productList = [];
  @override
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
  try {
    final url = '/home/${widget.tag}';
    Response response = await Caller.dio.get(url);

    print(response.toString());
    print(response.data);

    if (response.data != null && response.data is Map<String, dynamic>) {
      final responseData = response.data;
      if (responseData.containsKey("created_products")) {
        final List<dynamic> products = responseData["created_products"];
        if (products != null && products is List<dynamic>) {
          for (var product in products) {
            print(product);
            productList.add(mainProduct.fromJson(product));
          }
        } else {
          print("Invalid 'created_products' data format");
        }
      } else {
        print("Missing 'created_products' field in response");
      }
    } else {
      print("Invalid response data format");
    }
  } catch (e) {
    print(e);
  }
}


  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: screenHeight,
      child: Column(
        children: 
          productList.map((e) => ListCate(                            
                                      title: e.name!,
                                      imageUrl: e.picture_url!,
                                      tag: e.category_id.toString(),
                                      range: "23 km",
                                      owner: "Not yet",
                                      ))
                                  .toList(),
        
      )
    );
  }
  // Widget build(BuildContext context) {
  //   screenHeight = MediaQuery.of(context).size.height;
  //   screenWidth = MediaQuery.of(context).size.width;
  //   return Container(
  //     padding: EdgeInsets.only(left: 20, right: 20),
  //     height: screenHeight,
  //     child: Column(
  //       children: <Widget>[
  //         ListCate(
  //           title: 'Premium Wagyu A5',
  //           tag: 'Meat',
  //           imageUrl: 'wagyu',
  //           owner: 'Peter Parker',
  //           range: '2.5 km',
  //         ),
  //         ListCate(
  //           title: 'Kurobuta',
  //           tag: 'Meat',
  //           imageUrl: 'kurobuta',
  //           owner: 'Nawat Sujjaritrat',
  //           range: '1.8 km',
  //         ),
  //       ],
  //     ),
  //   );
  // }
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

class ListCate extends StatelessWidget {
  String title;
  String imageUrl;
  String tag;
  String range;
  String owner;

  ListCate(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.tag,
      required this.range,
      required this.owner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => InsideOrder())));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(4, 5),
            )
          ]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the border radius
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Container(
                    width: 110,
                    height: 110,
                    child: Image.asset(
                      'Images/Food/' + imageUrl + ".jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(tag),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          tag,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          range,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Text(
                          owner,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
