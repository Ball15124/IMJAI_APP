import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Categories(
            name: "Meat",
            imageUrl: "Meat",
            slug: "",
          ),
          Categories(
            name: "Veget&Fruit",
            imageUrl: "Veget&Fruit",
            slug: "",
          ),
          Categories(
            name: "Food",
            imageUrl: "Food",
            slug: "",
          ),
          Categories(
            name: "Flavoring",
            imageUrl: "Flavoring",
            slug: "",
          ),
          Categories(
            name: "Drink",
            imageUrl: "Drink",
            slug: "",
          ),
          Categories(
            name: "Snack",
            imageUrl: "Snack",
            slug: "",
          ),
          Categories(
            name: "Dessert",
            imageUrl: "Dessert",
            slug: "",
          ),
          Categories(
            name: "Food Waste",
            imageUrl: "Food Waste",
            slug: "",
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
      onTap: () {},
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
}
