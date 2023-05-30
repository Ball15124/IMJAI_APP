import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
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
            const TextField(
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Color.fromARGB(245, 249, 255, 255),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                //border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.key_rounded),
                filled: true,
                fillColor: Color.fromARGB(245, 249, 255, 255),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Perform login logic here
                String username = _usernameController.text;
                String password = _passwordController.text;
                print('Username: $username');
                print('Password: $password');
              },
              child: const Text(
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
                    onPressed: () {},
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
    );
  }
}
