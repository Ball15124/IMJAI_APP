import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/profile.dart';
import 'package:imjai_frontend/widget/orderDetail.dart';
import 'package:imjai_frontend/widget/orderStatusDetail.dart';

class recieverStatus extends StatefulWidget {
  const recieverStatus({super.key});

  @override
  State<recieverStatus> createState() => _recieverStatusState();
}

class _recieverStatusState extends State<recieverStatus> {
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
  int status = 0;
  int productId = 0;
  double doubleLat = 0;
  double doubleLong = 0;
  String setlocation_street = '';
  String setlocation_name = '';
  String locationLat = '';
  String locationLong = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchData(context);
      // getLocation();
    });
  }

  getLocation() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    Response locationRes = await Caller.dio.get("/products/location/$id");
    Map<String, dynamic> fetchLocation = locationRes.data;
    locationLat = fetchLocation['location_latitude'];
    locationLong = fetchLocation['location_longtitude'];
    print(locationLat);
    print(locationLong);
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
    // location_name = setlocation_name;
  }

  void fetchData(BuildContext context) async {
    try {
      final id = ModalRoute.of(context)!.settings.arguments as int;
      Response response = await Caller.dio.get("/products/products/$id");
      await getLocation();
      print(response.data);
      setState(() {
        print("change status page");
        final productData = mainProduct.fromJson(response.data["product"]);
        print(productData);
        productName = productData.name!;
        phone_number = productData.created_by_user!.phone_number!;
        productId = productData.id;
        status = productData.status!;
        print("status :" + status.toString());
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
        // getLocation();
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

  CameraPosition? cameraPosition;
  late GoogleMapController mapController;
  int Number = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      status == 1
                          ? Container(
                              padding: EdgeInsets.only(right: 10),
                              height: 500,
                              width: 600,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "Images/ReserveStatus/OrderTrackingImage.gif"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : status == 2
                              ? Container(
                                  height: 500,
                                  width: 600,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "Images/ReserveStatus/Chicken.avif"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : status == 3
                                  ? Container(
                                      width: 600,
                                      height: 500,
                                      child: Stack(
                                        children: [
                                          GoogleMap(
                                            onMapCreated: _onMapCreated,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target:
                                                  LatLng(doubleLat, doubleLong),
                                              zoom: 17,
                                            ),
                                            mapType: MapType.normal,
                                            onCameraMove: (CameraPosition
                                                cameraposition) {
                                              cameraPosition = cameraposition;
                                            },
                                          ),
                                          Center(
                                              //picker image on google map
                                              child: Icon(
                                            Icons.location_on_rounded,
                                            size: 40,
                                            color: Colors.orange,
                                          )),
                                        ],
                                      ),
                                    )
                                  : status == 4
                                      ? Container(
                                          width: 600,
                                          height: 500,
                                          child: Center(
                                            child:
                                                Icon(Icons.check_box_rounded),
                                          ),
                                        )
                                      : Container(
                                          width: 600,
                                          height: 500,
                                          child: Center(
                                            child:
                                                Icon(Icons.check_box_rounded),
                                          ),
                                        ),
                      Positioned(
                        top: 40,
                        left: 5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop((context));
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 35,
                            color: Color.fromARGB(255, 250, 122, 48),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 350),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 15, right: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Order# " +
                                                      productId.toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  status == 2
                                                      ? "Preparing Order"
                                                      : status == 3
                                                          ? "Waiting for you to pickup"
                                                          : status == 4
                                                              ? "Complete"
                                                              : "Waiting giver to confirm",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Location",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Time",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  setlocation_name +
                                                      ", \n" +
                                                      setlocation_street,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  ". . .",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 0, left: 20, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                              backgroundImage: AssetImage(
                                                  "Images/profile.jpg"),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    ownerName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 40),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                      onPressed: () {},
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
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Order Details",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                )
                                              ],
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    productName +
                                                        " - " +
                                                        productDetail,
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 5, left: 0, right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Time",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Categories",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Range",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 0, right: 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    availableTime,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(category,
                                                      textAlign:
                                                          TextAlign.center),
                                                  Text("2.5 km",
                                                      textAlign:
                                                          TextAlign.center)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5)))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '1 items',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        side: const BorderSide(
                                            color: Colors.red, width: 2),
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                      ),
                                      onPressed: () {
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
