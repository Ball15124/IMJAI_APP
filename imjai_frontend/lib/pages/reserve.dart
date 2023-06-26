import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/reservetoproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/widget/categorieswidget.dart';
import 'package:imjai_frontend/widget/listreservewidget.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/searchwidget.dart';

class Reserve extends StatefulWidget {
  const Reserve({super.key});

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  var currentIndex = 0;

  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  List<reserveToProduct> reserved_product = [];

  @override
  void initState() {
    super.initState();
    // selectedDateTime = DateTime.now().toString();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData(context);
    });
  }

  void fetchData(BuildContext context) async {
    try {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      Response response = await Caller.dio.get("/products/getreserves");

      setState(() {
        print('test');
        List<dynamic> reserved = response.data["reserved_products"];
        print(1212);
        print(reserved);
        reserved_product = reserved
            .map<reserveToProduct>((json) => reserveToProduct.fromJson(json))
            .toList();

        print(reserved_product);
        print(111111);
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
                            "My Reserve",
                            style: TextStyle(
                                fontSize: screenWidth / 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: screenHeight / 45),
                        Row(
                          children: [
                            Text(
                              "My Reserve List",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth / 20),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 65),
                        // ListReserveWidget(),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                              children: reserved_product
                                  .map((e) => reserveList(
                                        id: e.reserved_product!.id,
                                        title:
                                            e.reserved_product?.name as String,
                                        imageUrl: e.reserved_product
                                            ?.picture_url as String,
                                        tag: e.reserved_product?.category_id
                                            .toString() as String,
                                        owner: e.reserved_product!
                                                .created_by_user!.firstname! +
                                            " " +
                                            e.reserved_product!.created_by_user!
                                                .lastname!,
                                        range: "23 km",
                                        status: e.reserved_product!.status!
                                            .toString(),
                                      ))
                                  .toList()),
                        )
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
