import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/login.dart';
import 'package:imjai_frontend/widget/categorieswidget.dart';
import 'package:imjai_frontend/widget/infoProfile.dart';
import 'package:imjai_frontend/widget/listorderwidget.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:imjai_frontend/widget/searchwidget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleEditable() {
    setState(() {
      isEditable = !isEditable;
      if (!isEditable) {
        // Save the edited text when editing is complete
        labelText = _controller.text;
        _controller.clear();
      }
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
                    padding: EdgeInsets.only(top: 60),
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop((context));
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 35,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 50),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    color: primary,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: screenHeight / 45),
                        Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 47,
                                  backgroundImage:
                                      AssetImage("Images/profile.jpg"),
                                ),
                                Positioned(
                                  bottom: -8,
                                  right: -10,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            const CircleBorder()),
                                        minimumSize: MaterialStateProperty.all(
                                          const Size(30,
                                              30), // Adjust the size to make the button smaller
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color.fromARGB(
                                                    255, 246, 146, 32)),
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 18,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Gwen Camiron",
                                  style: TextStyle(fontSize: 23),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: screenHeight / 65),
                        Info(
                          title: "First name",
                          data: "Gwen",
                          color: Colors.black,
                          enable: false,
                        ),
                        Info(
                          title: "Last name",
                          data: "Camiron",
                          enable: false,
                          color: Colors.black,
                        ),
                        Info(
                            title: "Email",
                            data: "gwen.cami@gmail.com",
                            color: Colors.black,
                            enable: false),
                        Stack(
                          children: [
                            Info(
                              title: "Contact",
                              data: labelText,
                              enable: isEditable,
                              color: Colors.black,
                              controller: _controller,
                            ),
                            Positioned(
                                bottom: 3,
                                right: -10,
                                child: TextButton(
                                    onPressed: () {
                                      toggleEditable();
                                    },
                                    child: Text(
                                      isEditable ? "Done" : "Edit",
                                      style: TextStyle(color: Colors.grey),
                                    ))),
                          ],
                        ),
                        Info(
                            title: "Birth Day",
                            color: Colors.black,
                            data: "14 Febuary 2002",
                            enable: false),
                        const SizedBox(
                          height: 200,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            side: const BorderSide(
                                color: Colors.orange, width: 2),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ));
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    ),
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
