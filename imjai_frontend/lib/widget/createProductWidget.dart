import 'dart:core';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fluttertagselector/fluttertagselector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertagselector/tag_class.dart';
import 'package:imjai_frontend/pages/location.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/product.dart';
import 'package:imjai_frontend/widget/chiptag.dart';
import 'package:imjai_frontend/widget/mapScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProductWidget extends StatefulWidget {
  const CreateProductWidget({super.key});

  @override
  State<CreateProductWidget> createState() => _CreateProductWidgetState();
}

class _CreateProductWidgetState extends State<CreateProductWidget> {
  TextEditingController proname = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController time = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future<void> _uploadImage() async {
    try {
      String apiUrl = 'http://localhost:3306/image/upload';

      if (image == null) {
        print('No image selected');
        return;
      }

      // Create Dio instance
      Dio dio = Dio();

      // Create form data

      FocusManager.instance.primaryFocus?.unfocus();
      SharedPreferences productLocation = await SharedPreferences.getInstance();
      String productLatitude = productLocation.getString('productLatitude')!;
      print(productLatitude);
      String productLongtitude =
          productLocation.getString('productLongtitude')!;
      print(productLongtitude);
      SharedPreferences productTag = await SharedPreferences.getInstance();
      int productCategory = productTag.getInt('tag')!;
      print(productCategory);
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(image!.path, filename: 'image.jpg'),
        'productName': proname.text,
        "product_name": proname.text,
        "product_picture": "",
        "product_description": description.text,
        "product_time": time.text,
        "category_id": productCategory,
        "locate_latitude": productLatitude,
        "locate_longtitude": productLongtitude,
        "status": 0,
        "reserved_yet": false,
      });

      // Send the image file to the backend
      if (productLatitude == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Location not found!'),
              content: const Text('Please set your product current location!'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        Response response =
            await Caller.dio.post("/image/upload", data: formData);
        print("after submitted");
        print(response.data);
        if (response.statusCode == 200) {
          Navigator.pop((context));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => (NavigationbarWidget())));
          print('Image uploaded successfully');
        } else {
          print('Failed to upload image. Status code: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300]),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(' From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[300]),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text(' From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void saveInfo() async {
    FocusManager.instance.primaryFocus?.unfocus();
    SharedPreferences productLocation = await SharedPreferences.getInstance();
    String productLatitude = productLocation.getString('productLatitude')!;
    print(productLatitude);
    String productLongtitude = productLocation.getString('productLongtitude')!;
    print(productLongtitude);
    SharedPreferences productTag = await SharedPreferences.getInstance();
    int productCategory = productTag.getInt('tag')!;
    print(productCategory);
    if (productLatitude == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location not found!'),
            content: const Text('Please set your product current location!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      await Caller.dio.post("/products", data: {
        "product_name": proname.text,
        "product_picture": "",
        "product_description": description.text,
        "product_time": time.text,
        "category_id": productCategory,
        "locate_latitude": productLatitude,
        "locate_longtitude": productLongtitude,
        "status": 0,
        "reserved_yet": false,
      }).then((response) {
        print(response.data);
        productLocation.setString('productLatitude', "");
        productLocation.setString('productLongtitude', "");
      })
          // .onError((DioError error, _) {
          //   Caller.handle(context, error);
          // })
          .whenComplete(() {
        Navigator.pop((context));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => (NavigationbarWidget())));
      });
    }
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              child: image != null
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.file_upload_rounded,
                        size: 35,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        myAlert();
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return AlertDialog(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8)),
                        //         title: Text('Please choose media to select'),
                        //         content: Container(
                        //           height: MediaQuery.of(context).size.height / 6,
                        //           child: Column(
                        //             children: [
                        //               ElevatedButton(
                        //                 style: ElevatedButton.styleFrom(
                        //                     backgroundColor: Colors.orange[300]),
                        //                 //if user click this button, user can upload image from gallery
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
                        //                   getImage(ImageSource.gallery);
                        //                 },
                        //                 child: Row(
                        //                   children: [
                        //                     Icon(Icons.image),
                        //                     Text(' From Gallery'),
                        //                   ],
                        //                 ),
                        //               ),
                        //               ElevatedButton(
                        //                 style: ElevatedButton.styleFrom(
                        //                     backgroundColor: Colors.orange[300]),
                        //                 //if user click this button. user can upload image from camera
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
                        //                   getImage(ImageSource.camera);
                        //                 },
                        //                 child: Row(
                        //                   children: [
                        //                     Icon(Icons.camera),
                        //                     Text(' From Camera'),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     });
                      },
                    ),
            ),
            SizedBox(height: screenHeight / 35),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Product Name", proname),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Description", description),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Available Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            customField("Available Time", time),
            SizedBox(height: screenHeight / 45),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            ChipTag(),
            SizedBox(height: screenHeight / 85),
            Container(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor: Colors.white,
                minimumSize: Size(screenWidth - 30, 50),
              ),
              icon: const Icon(
                Icons.location_on_rounded,
                color: Colors.orange,
                size: 20.0,
              ),
              label: const Text(
                'Location for your Product',
                style: TextStyle(fontSize: 15, color: Colors.orange),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Location()));
              },
            ),
            SizedBox(height: screenHeight / 60),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        // saveInfo();
                        _uploadImage();
                      },
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller) {
    return Container(
      width: screenWidth - 35,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 236, 237, 239),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.grey,
            //   spreadRadius: 2,
            //   blurRadius: 5,
            //   offset: Offset(5, 7),
            // )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth / 12),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight / 40,
                    ),
                    hintText: hint,
                    border: InputBorder.none),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
