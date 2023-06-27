import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imjai_frontend/model/me.dart';
import 'package:imjai_frontend/pages/caller.dart';
import 'package:imjai_frontend/pages/login.dart';
import 'package:imjai_frontend/widget/infoProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widget/navigationbarwidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var currentIndex = 0;
  bool isEditable = false;
  TextEditingController _controller = TextEditingController();
  String labelText = "097 020 0803";
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  XFile? image;
  int picCheck = 0;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      if (image != null) {
        picCheck = 1;
      } else {
        picCheck = 0;
      }
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
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(image!.path, filename: 'image.jpg'),
      });

      // Send the image file to the backend
      Response response =
          await Caller.dio.post("/image/profile/upload", data: formData);
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
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text('Please choose media to select'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[300],
                  ),
                  //if user clicks this button, user can upload image from gallery
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
                    backgroundColor: Colors.orange[300],
                  ),
                  //if user clicks this button, user can upload image from camera
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
      },
    );
  }

  String phone_number = '';
  String fname = '';
  String lastname = '';
  String email = '';
  String profileUrl = '';
  String birthdate = '';
  // int picCheck = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      Response response = await Caller.dio.get("/me");
      // Response productResponse = await Caller.dio.get("/home/list");
      setState(() {
        final data = meProfile.fromJson(response.data);
        fname = data.firstname!;
        lastname = data.lastname!;
        email = data.email!;
        phone_number = data.phone_number!;
        birthdate = data.birthdate!;
        profileUrl = data.profile_url!;
        print(profileUrl);
        print(data.firstname);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleEditable() {
    setState(() {
      isEditable = !isEditable;
      // Save the edited text when editing is complete
      // phone_number = _controller.text;
      // final phoneNumber = _controller.text;
      // print(phoneNumber);
      // print(phone_number);

      //   Caller.dio.post("/me/update", data: {
      //     "phone_number": phone_number,
      //   }).then((response) {
      //     print("Success");
      //   }).catchError((error) {
      //     print("Error: $error");
      //   });
      //   _controller.clear();
      // print(phone_number);
      // Caller.dio.post("/me/update", data: {
      //   "phone_number": phone_number,
      // }).then((response) {
      //   print("Success");
      // }).catchError((error) {
      //   print("Error: $error");
      // });
    });
  }

  void sendInfo() {
    setState(() {
      isEditable = !isEditable;
      print("send Info");
      // Save the edited text when editing is complete
      phone_number = _controller.text;
      final phoneNumber = _controller.text;
      print(phoneNumber);
      print(phone_number);

      Caller.dio.post("/me/update", data: {
        "phone_number": phone_number,
      }).then((response) {
        print("Success");
      }).catchError((error) {
        print("Error: $error");
      });
      // _controller.clear();
      print(phone_number);
      // Caller.dio.post("/me/update", data: {
      //   "phone_number": phone_number,
      // }).then((response) {
      //   print("Success");
      // }).catchError((error) {
      //   print("Error: $error");
      // });
    });
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
                  Container(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        //Spacer(),
                        Container(
                          //margin: EdgeInsets.only(right: 50),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Spacer(),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              image != null ? _uploadImage() : null;
                              // Navigator.pop(context);
                            },
                            icon: Icon(Icons.save_rounded,
                                size: 35,
                                color: image != null
                                    ? Colors.orange
                                    : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenHeight / 45),
                        Column(
                          children: [
                            Stack(
                              children: [
                                image != null
                                    ? CircleAvatar(
                                        radius: 90,
                                        backgroundImage:
                                            FileImage(File(image!.path)),
                                      )
                                    : profileUrl != ''
                                        ? CircleAvatar(
                                            radius: 90,
                                            backgroundImage:
                                                NetworkImage(profileUrl),
                                          )
                                        : CircleAvatar(
                                            radius: 90,
                                          ),
                                Positioned(
                                  bottom: -5,
                                  right: 13,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      myAlert();
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        const CircleBorder(),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                        const Size(30, 30),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                          255,
                                          237,
                                          158,
                                          2,
                                        ), // <-- Button color
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            // Column(
                            //   children: [
                            //     Text(
                            //       fname + " " + lastname,
                            //       style: TextStyle(fontSize: 23),
                            //     ),
                            //     const SizedBox(
                            //       height: 20,
                            //     )
                            //   ],
                            // ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 65),
                        Info(
                          title: "First name",
                          data: fname,
                          color: Colors.black,
                          enable: false,
                        ),
                        Info(
                          title: "Last name",
                          data: lastname,
                          enable: false,
                          color: Colors.black,
                        ),
                        Info(
                          title: "Email",
                          data: email,
                          color: Colors.black,
                          enable: false,
                        ),
                        Stack(
                          children: [
                            Info(
                              title: "Contact",
                              data: phone_number,
                              enable: isEditable,
                              text: TextInputType.phone,
                              color: Colors.black,
                              controller: _controller,
                            ),
                            isEditable == true
                                ? Positioned(
                                    bottom: 3,
                                    right: -10,
                                    child: TextButton(
                                      onPressed: () {
                                        print("This is phone number");
                                        print(phone_number);
                                        sendInfo();
                                      },
                                      child: Text(
                                        "Done",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    bottom: 3,
                                    right: -10,
                                    child: TextButton(
                                      onPressed: () {
                                        toggleEditable();
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        Info(
                          title: "Birth Day",
                          color: Colors.black,
                          data: birthdate.isNotEmpty
                              ? DateFormat("E, dd-MM-yyyy").format(
                                  DateTime.parse(birthdate)
                                      .add(Duration(hours: 8)),
                                )
                              : '',
                          enable: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            side: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  title: const Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                  content: const Text('Do you want to Logout?'),
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
                                        backgroundColor: Colors.orange,
                                      ),
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    Login())));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        Container(height: 30),
                      ],
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
}
