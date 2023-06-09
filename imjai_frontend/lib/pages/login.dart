import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/model/authen.dart';
import 'package:imjai_frontend/pages/caller.dart';

import 'package:imjai_frontend/pages/home.dart';
import 'package:imjai_frontend/pages/register.dart';
import 'package:imjai_frontend/widget/navigationbarwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Color.fromARGB(255, 255, 255, 255);

  @override
  void saveInfo() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_usernameController.text == "") {
      print("username null");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Can't find user"),
            content: Text("User not found!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      try {
        Response token = await Caller.dio.get(
          "/login",
          data: {
            "username": _usernameController.text,
            "password": _passwordController.text,
          },
        );
        print("awdawdwad");
        print(token.data);

        if (token.statusCode != 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("User not found"),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return; // Stop execution if user not found
        } else {
          CallbackResponse cb = CallbackResponse.fromJson(token.data);
          print(cb.token);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          _usernameController.clear();
          _passwordController.clear();
          await prefs.setString('token', cb.token);
          Caller.setToken(cb.token);
          print(cb.token);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavigationbarWidget()));
          // }
        }
      } catch (e) {
        if (e is DioError) {
          if (e.response?.statusCode == 404) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text("User not found"),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'Images/ImJai Logo.png', // Replace with your logo image path
                width: 200,
                height: 200,
              ),
              Text(
                "Hi, there!",
                style: TextStyle(
                  fontSize: screenWidth / 25,
                  color: Colors.black,
                ),
              ),
              Text(
                "Let's Get Started",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth / 25,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenHeight / 20),
              customField('Username', _usernameController, false,
                  Icons.account_circle_outlined, Colors.orange),
              const SizedBox(height: 16.0),
              customField('Password', _passwordController, true,
                  Icons.key_rounded, Colors.orange),
              SizedBox(height: screenHeight / 45),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Perform login logic here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  print('Username: $username');
                  print('Password: $password');
                  saveInfo();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const NavigationbarWidget()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: screenHeight / 5,
              ),
              Container(
                  child: Column(
                children: [
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.orange, width: 2),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller,
      bool obscure, IconData icon, Color color) {
    return Container(
      width: screenWidth - 35,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 232, 242, 251),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(5, 7),
            )
          ]),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 6,
            child: Icon(
              icon,
              size: screenWidth / 15,
              color: color,
            ),
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
                obscureText: obscure,
                onSaved: (String? email) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
