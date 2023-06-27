import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:imjai_frontend/model/mainproduct.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';

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
  String ownerPicture = '';
  String locationLat = '';
  String locationLong = '';
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
    // _subscription.cancel();
    timer.cancel();
    super.dispose();
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
        if (status == 0) {
          timer.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Order Cancelled'),
                content:
                    const Text('Sorry, the giver have cancelled your order.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NavigationbarWidget()));
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
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
        ownerPicture = productData.created_by_user!.profile_url!;
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
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: primary,
        body: Stack(
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
                            image:
                                AssetImage("Images/ReserveStatus/Chicken.avif"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : status == 3
                        ? Container(
                            width: 600,
                            height: 400,
                            child: Stack(
                              children: [
                                GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(doubleLat, doubleLong),
                                    zoom: 17,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId(setlocation_name),
                                      position: LatLng(doubleLat, doubleLong),
                                    ),
                                  },
                                  mapType: MapType.normal,
                                  onCameraMove:
                                      (CameraPosition cameraposition) {
                                    cameraPosition = cameraposition;
                                  },
                                ),
                              ],
                            ),
                          )
                        : status == 4
                            ? Container(
                                width: 400,
                                height: 400,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "Images/ReserveStatus/Done.gif"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 600,
                                height: 500,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
            Positioned(
              top: 40,
              left: 5,
              child: IconButton(
                onPressed: () {
                  timer.cancel();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => NavigationbarWidget())));
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                padding: EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Order# " + productId.toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Location",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
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
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: screenHeight / 75),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                padding: EdgeInsets.only(
                                    top: 0, left: 20, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(ownerPicture),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            ownerName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: IconButton(
                                              onPressed: () async {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(phone_number);
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
                                              color: Colors.grey, fontSize: 17),
                                        )
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            productName + " - " + productDetail,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 0, right: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Time",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "Categories",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            "Range",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 0, right: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            availableTime,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(category,
                                              textAlign: TextAlign.center),
                                          Text("2.5 km",
                                              textAlign: TextAlign.center)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.5)))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                            SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                side: const BorderSide(
                                    color: Colors.red, width: 2),
                                minimumSize: const Size(double.infinity, 50),
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
                                          },
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
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        )
        // Column(
        //   children: [
        //     SingleChildScrollView(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Stack(
        //                 alignment: Alignment.topLeft,
        //                 children: [
        //                   status == 1
        //                       ? Container(
        //                           padding: EdgeInsets.only(right: 10),
        //                           height: 500,
        //                           width: 600,
        //                           decoration: BoxDecoration(
        //                             image: DecorationImage(
        //                               image: AssetImage(
        //                                   "Images/ReserveStatus/OrderTrackingImage.gif"),
        //                               fit: BoxFit.cover,
        //                             ),
        //                           ),
        //                         )
        //                       : status == 2
        //                           ? Container(
        //                               height: 500,
        //                               width: 600,
        //                               decoration: BoxDecoration(
        //                                 image: DecorationImage(
        //                                   image: AssetImage(
        //                                       "Images/ReserveStatus/Chicken.avif"),
        //                                   fit: BoxFit.cover,
        //                                 ),
        //                               ),
        //                             )
        //                           : status == 3
        //                               ? Container(
        //                                   width: 600,
        //                                   height: 400,
        //                                   child: Stack(
        //                                     children: [
        //                                       GoogleMap(
        //                                         onMapCreated: _onMapCreated,
        //                                         initialCameraPosition:
        //                                             CameraPosition(
        //                                           target: LatLng(
        //                                               doubleLat, doubleLong),
        //                                           zoom: 17,
        //                                         ),
        //                                         markers: {
        //                                           Marker(
        //                                             markerId: MarkerId(
        //                                                 setlocation_name),
        //                                             position: LatLng(
        //                                                 doubleLat, doubleLong),
        //                                           ),
        //                                         },
        //                                         mapType: MapType.normal,
        //                                         onCameraMove: (CameraPosition
        //                                             cameraposition) {
        //                                           cameraPosition = cameraposition;
        //                                         },
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 )
        //                               : status == 4
        //                                   ? Container(
        //                                       width: 400,
        //                                       height: 400,
        //                                       decoration: BoxDecoration(
        //                                         image: DecorationImage(
        //                                           image: AssetImage(
        //                                               "Images/ReserveStatus/Done.gif"),
        //                                           fit: BoxFit.cover,
        //                                         ),
        //                                       ),
        //                                     )
        //                                   : Container(
        //                                       width: 600,
        //                                       height: 500,
        //                                       child: Center(
        //                                         child:
        //                                             CircularProgressIndicator(),
        //                                       ),
        //                                     ),
        //                   Positioned(
        //                     top: 40,
        //                     left: 5,
        //                     child: IconButton(
        //                       onPressed: () {
        //                         timer.cancel();
        //                         Navigator.push(
        //                             context,
        //                             MaterialPageRoute(
        //                                 builder: ((context) =>
        //                                     NavigationbarWidget())));
        //                       },
        //                       icon: const Icon(
        //                         Icons.close_rounded,
        //                         size: 35,
        //                         color: Color.fromARGB(255, 250, 122, 48),
        //                       ),
        //                     ),
        //                   ),
        //                   Container(
        //                       margin: EdgeInsets.only(top: 350),
        //                       child: Column(
        //                         children: [
        //                           Container(
        //                             padding: EdgeInsets.only(
        //                                 top: 20, left: 20, right: 20),
        //                             child: Column(
        //                               children: [
        //                                 Container(
        //                                   margin: EdgeInsets.only(bottom: 20),
        //                                   height: 180,
        //                                   width: 400,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius:
        //                                         BorderRadius.circular(10),
        //                                     boxShadow: [
        //                                       BoxShadow(
        //                                         color:
        //                                             Colors.grey.withOpacity(0.3),
        //                                         spreadRadius: 1,
        //                                         blurRadius: 5,
        //                                         offset: Offset(4, 5),
        //                                       )
        //                                     ],
        //                                     color: Color.fromARGB(
        //                                         255, 255, 255, 255),
        //                                   ),
        //                                   child: Container(
        //                                     padding: EdgeInsets.only(
        //                                         top: 10, left: 15, right: 15),
        //                                     child: Column(
        //                                       children: [
        //                                         Row(
        //                                           children: [
        //                                             Text(
        //                                               "Order# " +
        //                                                   productId.toString(),
        //                                               style: TextStyle(
        //                                                   color: Colors.grey,
        //                                                   fontSize: 15),
        //                                             )
        //                                           ],
        //                                         ),
        //                                         SizedBox(
        //                                           height: 5,
        //                                         ),
        //                                         Row(
        //                                           children: [
        //                                             Text(
        //                                               status == 2
        //                                                   ? "Preparing Order"
        //                                                   : status == 3
        //                                                       ? "Waiting for you to pickup"
        //                                                       : status == 4
        //                                                           ? "Complete"
        //                                                           : "Waiting giver to confirm",
        //                                               style: TextStyle(
        //                                                   color: Color.fromARGB(
        //                                                       255, 0, 0, 0),
        //                                                   fontSize: 18,
        //                                                   fontWeight:
        //                                                       FontWeight.bold),
        //                                             )
        //                                           ],
        //                                         ),
        //                                         SizedBox(
        //                                           height: 10,
        //                                         ),
        //                                         Row(
        //                                           mainAxisAlignment:
        //                                               MainAxisAlignment
        //                                                   .spaceBetween,
        //                                           children: [
        //                                             Text(
        //                                               "Location",
        //                                               style: TextStyle(
        //                                                   color: Colors.grey,
        //                                                   fontSize: 15),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                         SizedBox(
        //                                           height: 5,
        //                                         ),
        //                                         Row(
        //                                           mainAxisAlignment:
        //                                               MainAxisAlignment
        //                                                   .spaceBetween,
        //                                           children: [
        //                                             Container(
        //                                               child: Text(
        //                                                 () {
        //                                                   if (setlocation_name ==
        //                                                       "") {
        //                                                     return "No location found, \nPleace contact giver!";
        //                                                   } else {
        //                                                     return setlocation_name +
        //                                                         ", \n" +
        //                                                         setlocation_street;
        //                                                   }
        //                                                 }(),
        //                                                 style: TextStyle(
        //                                                     color: Color.fromARGB(
        //                                                         255, 0, 0, 0),
        //                                                     fontSize:
        //                                                         screenHeight /
        //                                                             75),
        //                                               ),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                         SizedBox(
        //                                           height: 10,
        //                                         ),
        //                                         Row(
        //                                           mainAxisAlignment:
        //                                               MainAxisAlignment
        //                                                   .spaceBetween,
        //                                           children: [
        //                                             Text(
        //                                               "Time",
        //                                               style: TextStyle(
        //                                                   color: Colors.grey,
        //                                                   fontSize: 15),
        //                                             ),
        //                                           ],
        //                                         ),
        //                                         SizedBox(
        //                                           height: 5,
        //                                         ),
        //                                         Row(
        //                                           children: [
        //                                             Text(
        //                                               availableTime,
        //                                               style: TextStyle(
        //                                                   color: Color.fromARGB(
        //                                                       255, 0, 0, 0),
        //                                                   fontSize: 13),
        //                                             ),
        //                                           ],
        //                                         )
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   margin: EdgeInsets.only(bottom: 20),
        //                                   height: 70,
        //                                   width: 400,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius:
        //                                         BorderRadius.circular(10),
        //                                     boxShadow: [
        //                                       BoxShadow(
        //                                         color:
        //                                             Colors.grey.withOpacity(0.3),
        //                                         spreadRadius: 1,
        //                                         blurRadius: 5,
        //                                         offset: Offset(4, 5),
        //                                       )
        //                                     ],
        //                                     color: Color.fromARGB(
        //                                         255, 255, 255, 255),
        //                                   ),
        //                                   child: Container(
        //                                     padding: EdgeInsets.only(
        //                                         top: 0, left: 20, right: 10),
        //                                     child: Row(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.spaceBetween,
        //                                       children: [
        //                                         CircleAvatar(
        //                                           radius: 25,
        //                                           backgroundImage:
        //                                               NetworkImage(ownerPicture),
        //                                         ),
        //                                         Container(
        //                                           padding:
        //                                               EdgeInsets.only(left: 0),
        //                                           child: Row(
        //                                             children: [
        //                                               Text(
        //                                                 ownerName,
        //                                                 style: TextStyle(
        //                                                     fontWeight:
        //                                                         FontWeight.bold,
        //                                                     fontSize: 15),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         Container(
        //                                           padding:
        //                                               EdgeInsets.only(left: 40),
        //                                           child: Row(
        //                                             children: [
        //                                               Container(
        //                                                 child: IconButton(
        //                                                   onPressed: () async {
        //                                                     await FlutterPhoneDirectCaller
        //                                                         .callNumber(
        //                                                             phone_number);
        //                                                   },
        //                                                   icon: const Icon(
        //                                                     Icons.phone,
        //                                                     size: 30,
        //                                                     color: Colors.orange,
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Container(
        //                                   height: 180,
        //                                   width: 400,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius:
        //                                         BorderRadius.circular(10),
        //                                     boxShadow: [
        //                                       BoxShadow(
        //                                         color:
        //                                             Colors.grey.withOpacity(0.3),
        //                                         spreadRadius: 1,
        //                                         blurRadius: 5,
        //                                         offset: Offset(4, 5),
        //                                       )
        //                                     ],
        //                                     color: Color.fromARGB(
        //                                         255, 255, 255, 255),
        //                                   ),
        //                                   child: Container(
        //                                     padding: EdgeInsets.only(
        //                                         top: 10, left: 15, right: 15),
        //                                     child: Column(
        //                                       mainAxisAlignment:
        //                                           MainAxisAlignment.spaceEvenly,
        //                                       children: [
        //                                         Row(
        //                                           children: [
        //                                             Text(
        //                                               "Order Details",
        //                                               style: TextStyle(
        //                                                   color: Colors.grey,
        //                                                   fontSize: 17),
        //                                             )
        //                                           ],
        //                                         ),
        //                                         Container(
        //                                           child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,
        //                                             children: [
        //                                               Text(
        //                                                 productName +
        //                                                     " - " +
        //                                                     productDetail,
        //                                                 style: TextStyle(
        //                                                     fontSize: 15),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         Container(
        //                                           padding: EdgeInsets.only(
        //                                               top: 5, left: 0, right: 0),
        //                                           child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,
        //                                             children: [
        //                                               Text(
        //                                                 "Time",
        //                                                 textAlign:
        //                                                     TextAlign.center,
        //                                                 style: TextStyle(
        //                                                     color: Colors.grey),
        //                                               ),
        //                                               Text(
        //                                                 "Categories",
        //                                                 textAlign:
        //                                                     TextAlign.center,
        //                                                 style: TextStyle(
        //                                                     color: Colors.grey),
        //                                               ),
        //                                               Text(
        //                                                 "Range",
        //                                                 textAlign:
        //                                                     TextAlign.center,
        //                                                 style: TextStyle(
        //                                                     color: Colors.grey),
        //                                               )
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         Container(
        //                                           padding: EdgeInsets.only(
        //                                               top: 10, left: 0, right: 0),
        //                                           child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,
        //                                             children: [
        //                                               Text(
        //                                                 availableTime,
        //                                                 textAlign:
        //                                                     TextAlign.center,
        //                                               ),
        //                                               Text(category,
        //                                                   textAlign:
        //                                                       TextAlign.center),
        //                                               Text("2.5 km",
        //                                                   textAlign:
        //                                                       TextAlign.center)
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         Container(
        //                                           padding: EdgeInsets.only(
        //                                               top: 10, bottom: 10),
        //                                           decoration: BoxDecoration(
        //                                               border: Border(
        //                                                   top: BorderSide(
        //                                                       color: Colors.grey
        //                                                           .withOpacity(
        //                                                               0.5)))),
        //                                           child: Row(
        //                                             mainAxisAlignment:
        //                                                 MainAxisAlignment
        //                                                     .spaceBetween,
        //                                             children: [
        //                                               Text(
        //                                                 'Total',
        //                                                 style: TextStyle(
        //                                                     color: Colors.black,
        //                                                     fontWeight:
        //                                                         FontWeight.bold),
        //                                               ),
        //                                               Text(
        //                                                 '1 items',
        //                                                 style: TextStyle(
        //                                                     color: Colors.black,
        //                                                     fontWeight:
        //                                                         FontWeight.bold),
        //                                               )
        //                                             ],
        //                                           ),
        //                                         )
        //                                       ],
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 SizedBox(height: 20),
        //                                 ElevatedButton(
        //                                   style: ElevatedButton.styleFrom(
        //                                     backgroundColor: Colors.red,
        //                                     side: const BorderSide(
        //                                         color: Colors.red, width: 2),
        //                                     minimumSize:
        //                                         const Size(double.infinity, 50),
        //                                   ),
        //                                   onPressed: () {
        //                                     showDialog(
        //                                       context: context,
        //                                       builder: (BuildContext context) {
        //                                         return AlertDialog(
        //                                           backgroundColor: Color.fromARGB(
        //                                               255, 255, 255, 255),
        //                                           shape: RoundedRectangleBorder(
        //                                               borderRadius:
        //                                                   BorderRadius.circular(
        //                                                       10.0)),
        //                                           title: Text(
        //                                             'Warning',
        //                                             style: TextStyle(
        //                                                 fontSize: 20,
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 color: Colors.red),
        //                                           ),
        //                                           content: const Text(
        //                                               'Do you want to cancel this product?'),
        //                                           actions: <Widget>[
        //                                             TextButton(
        //                                               child: const Text(
        //                                                 'No',
        //                                                 style: TextStyle(
        //                                                     fontSize: 15,
        //                                                     color: Colors.orange,
        //                                                     fontWeight:
        //                                                         FontWeight.bold),
        //                                               ),
        //                                               style: TextButton.styleFrom(
        //                                                 backgroundColor:
        //                                                     Colors.white,
        //                                                 side: BorderSide(
        //                                                   color: Colors.orange,
        //                                                   width: 1,
        //                                                 ),
        //                                               ),
        //                                               onPressed: () {
        //                                                 Navigator.of(context)
        //                                                     .pop();
        //                                               },
        //                                             ),
        //                                             TextButton(
        //                                               child: const Text(
        //                                                 'Yes',
        //                                                 style: TextStyle(
        //                                                     fontSize: 15,
        //                                                     color: Colors.white,
        //                                                     fontWeight:
        //                                                         FontWeight.bold),
        //                                               ),
        //                                               style: TextButton.styleFrom(
        //                                                 backgroundColor:
        //                                                     Colors.red,
        //                                               ),
        //                                               onPressed: () async {
        //                                                 try {
        //                                                   timer.cancel();
        //                                                   Response reserve =
        //                                                       await Caller.dio
        //                                                           .post(
        //                                                     "/reserveReciever/reserves/cancel/$productId",
        //                                                   );
        //                                                   Navigator.push(
        //                                                       context,
        //                                                       MaterialPageRoute(
        //                                                           builder:
        //                                                               (context) =>
        //                                                                   (NavigationbarWidget())));
        //                                                   print(reserve.data);
        //                                                 } catch (e) {
        //                                                   print(e);
        //                                                 }
        //                                               },
        //                                             ),
        //                                           ],
        //                                         );
        //                                       },
        //                                     );
        //                                   },
        //                                   child: const Text(
        //                                     'Cancel',
        //                                     style: TextStyle(
        //                                         fontWeight: FontWeight.bold,
        //                                         fontSize: 30,
        //                                         color: Color.fromARGB(
        //                                             255, 255, 255, 255)),
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       ))
        //                 ],
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
