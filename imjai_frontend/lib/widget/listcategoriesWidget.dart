import 'package:flutter/material.dart';

import '../pages/InsideOrder.dart';

class ListCategoriesWidget extends StatefulWidget {
  const ListCategoriesWidget({super.key});

  @override
  State<ListCategoriesWidget> createState() => _ListCategoriesWidgetState();
}

class _ListCategoriesWidgetState extends State<ListCategoriesWidget> {
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: screenHeight,
      child: Column(
        children: <Widget>[
          ListCate(
            title: 'Premium Wagyu A5',
            tag: 'Meat',
            imageUrl: 'wagyu',
            owner: 'Peter Parker',
            range: '2.5 km',
          ),
          ListCate(
            title: 'Kurobuta',
            tag: 'Meat',
            imageUrl: 'kurobuta',
            owner: 'Nawat Sujjaritrat',
            range: '1.8 km',
          ),
        ],
      ),
    );
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
