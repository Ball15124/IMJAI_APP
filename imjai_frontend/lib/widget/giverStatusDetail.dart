// import 'dart:ffi';

import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:im_stepper/stepper.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/model/me.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';

class giverStatusDetail extends StatefulWidget {
  const giverStatusDetail({super.key});

  @override
  State<giverStatusDetail> createState() => _giverStatusDetailState();
}

class _giverStatusDetailState extends State<giverStatusDetail> {
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
  String recieverName = '';
  String ownerPicture = '';
  String locationLat = '';
  String locationLong = '';
  double doubleLat = 0;
  double doubleLong = 0;
  String setlocation_street = '';
  String setlocation_name = '';
  String receiverLatitude = '';
  String receiverLongtitude = '';
  int status = 0;
  int productId = 0;
  late Timer timer;
  late StreamSubscription<int> _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData(context);
      // getLocation();
    });
  }

  @override
  void didChangeDependencies() {
    print('fetchData');
    fetchData(context);
    timer = Timer.periodic(new Duration(seconds: 3), (timer) {
      fetchData(context);
      print('refreshed');
    });
    // Move the code that depends on inherited widgets here
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
    timer.cancel();
  }

  getLocation() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Response locationRes = await Caller.dio.get("/products/location/$id");
    Map<String, dynamic> fetchLocation = locationRes.data;
    locationLat = fetchLocation['location_latitude'];
    locationLong = fetchLocation['location_longtitude'];
    print(locationLat);
    print(locationLong);
    if (locationLat == "") {
      print("No location found, Please contact giver!");
    } else {
      doubleLat = double.parse(locationLat);
      doubleLong = double.parse(locationLong);
      print(doubleLat);
      print(doubleLong);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(doubleLat, doubleLong);

      setlocation_street = placemarks.first.administrativeArea.toString() +
          ", " +
          placemarks.first.street.toString() +
          ", " +
          placemarks.first.country.toString();
      setlocation_name = placemarks.first.name.toString();
      print(setlocation_street);
      print(setlocation_name);
    }

    // location_name = setlocation_name;
  }

  String calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double lat1Radians = degreesToRadians(lat1);
    double lon1Radians = degreesToRadians(lon1);
    double lat2Radians = degreesToRadians(lat2);
    double lon2Radians = degreesToRadians(lon2);
    double latDiff = lat2Radians - lat1Radians;
    double lonDiff = lon2Radians - lon1Radians;
    double a = pow(sin(latDiff / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    String formattedDistance = distance.toStringAsFixed(2);

    return formattedDistance + ' km';
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void fetchData(BuildContext context) async {
    try {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      Response response = await Caller.dio.get("/products/products/$id");
      await getLocation();
      print(response.data);
      Response response2 = await Caller.dio.get("/me");
      setState(() {
        print("change status page");
        final productData = mainProduct.fromJson(response.data["product"]);
        print(productData);
        // final userData = meProfile.fromJson(response2.data);
        if (status == 0) {
          timer.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Order Cancelled'),
                content: const Text(
                    'Sorry, the receiver have cancelled your order.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      timer.cancel();
                      Navigator.pop((context));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        productName = productData.name!;
        print(productName);
        phone_number = productData.reserved!.reserved_users!.phone_number!;
        print(phone_number);
        productId = productData.id;
        print(productId);
        ownerPicture = productData.reserved!.reserved_users!.profile_url!;
        status = productData.status!;
        print(status);
        if (productData.reserved == null ||
            productData.reserved!.reserved_users == null) {
          recieverName = "Reciever not found!";
        } else {
          final reservedUsers = productData.reserved!.reserved_users;
          if (reservedUsers!.firstname == null ||
              reservedUsers.firstname!.isEmpty) {
            recieverName = "Reciever not found!";
          } else {
            recieverName =
                reservedUsers.firstname! + " " + reservedUsers.lastname!;
          }
        }

        print(recieverName);
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
        receiverLatitude =
            productData.reserved!.reserved_users!.location_latitude!;
        receiverLongtitude =
            productData.reserved!.reserved_users!.location_longtitude!;
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

  int activeStep = 0; // Initial step set to 5.
  bool isPass = false;
  final dotCount = [0, 1, 2, 3];

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
      // Handle other cases if neededF
      category = "Food Waste";
    } else {
      category = "No Categories";
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: Colors.orange,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 5,
                        color: Colors.orange,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: status >= 2 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color: status >= 2 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 65,
                        height: 5,
                        color: status >= 2 ? Colors.orange : Colors.grey,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: status >= 3 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color: status >= 3 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 5,
                        color: status >= 3 ? Colors.orange : Colors.grey,
                      ),
                      Container(
                        width: 25.0,
                        height: 25.0,
                        padding: EdgeInsets.all(0),
                        decoration: new BoxDecoration(
                          color: status >= 4 ? Colors.orange : Colors.grey,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(25.0)),
                          border: new Border.all(
                            color: status >= 4 ? Colors.orange : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Text(
                        "Waiting",
                        style: TextStyle(
                            color: status >= 1 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 42,
                      ),
                      Text(
                        "Preparing",
                        style: TextStyle(
                            color: status >= 2 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 43,
                      ),
                      Text(
                        "Ready",
                        style: TextStyle(
                            color: status >= 3 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      Text(
                        "Complete",
                        style: TextStyle(
                            color: status >= 4 ? Colors.orange : Colors.grey,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                onPressed: () {
                  timer.cancel();
                  Navigator.pop((context));
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 35,
                  color: Color.fromARGB(255, 250, 122, 48),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order# " + productId.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            status == 1
                                ? "Waiting you to confirm"
                                : status == 2
                                    ? "Order Preparing"
                                    : status == 3
                                        ? "Waiting for reciever to pick up"
                                        : "Complete",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            () {
                              if (setlocation_name == "") {
                                return "No location found, \nPleace contact giver!";
                              } else {
                                return setlocation_name +
                                    ", \n" +
                                    setlocation_street;
                              }
                            }(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            availableTime,
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(ownerPicture),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 180,
                        child: Wrap(
                          children: [
                            Text(
                              () {
                                if (recieverName.isNotEmpty) {
                                  return recieverName;
                                } else {
                                  return "Reciever not found!";
                                }
                              }(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
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
              ),
              Container(
                height: 180,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(4, 5),
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Order Details",
                            style: TextStyle(color: Colors.grey, fontSize: 17),
                          )
                        ],
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 0, right: 0),
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
                        padding: EdgeInsets.only(top: 10, left: 0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              availableTime,
                              textAlign: TextAlign.center,
                            ),
                            Text(category, textAlign: TextAlign.center),
                            Text(
                                status >= 1
                                    ? calculateDistance(
                                        double.parse(locationLatitude),
                                        double.parse(locationLongtitude),
                                        double.parse(receiverLatitude),
                                        double.parse(receiverLongtitude))
                                    : "Waiting for \n reserve",
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey.withOpacity(0.5)))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '1 items',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: status < 4
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  status < 4
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            side: const BorderSide(
                                color: Colors.orange, width: 2),
                            minimumSize: const Size(150, 60),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  title: Text(
                                    'Warning',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                  content: const Text(
                                      'Do you want to cancel this product?'),
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
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        try {
                                          timer.cancel();
                                          Response reserve =
                                              await Caller.dio.post(
                                            "/reserveReciever/reserves/cancel/$productId",
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      (NavigationbarWidget())));
                                          print(reserve.data);
                                        } catch (e) {
                                          print(e);
                                        }
                                        // Navigator.pop(context);
                                        // Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.orange),
                          ),
                        )
                      : Container(
                          width: 0,
                        ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.orange,
                          side: BorderSide(color: Colors.orange, width: 2),
                          minimumSize: Size(150, 60)),
                      onPressed: () {
                        if (activeStep == 3) {
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                                content: const Text(
                                    'Do you want to confirm this product?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Colors.red,
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
                                      // timer.cancel();
                                      await Caller.dio.post(
                                          "/reserveReciever/reserves/update/$productId");
                                      if (activeStep <= 3) {
                                        setState(() {
                                          activeStep++;
                                          Navigator.pop(context);
                                        });
                                      }
                                      if (activeStep > 3) {
                                        setState(() {
                                          activeStep = 3;
                                        });
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              title: Text(
                                                '',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'You have reach the process !'),
                                                ],
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    side: BorderSide(
                                                      color: Colors.orange,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      print(activeStep);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        status == 4 ? 'Complete' : "Confirm",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
