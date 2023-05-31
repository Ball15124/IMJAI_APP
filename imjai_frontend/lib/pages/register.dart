import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController userCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 4),
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
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'Images/ImJai Logo.png', // Replace with your logo image path
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "REGISTER",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: screenWidth / 20),
            ),
            const SizedBox(
              height: 20,
            ),
            customField('Email', emailCon, false, Icons.email, Colors.orange),
            customField(
                'Username', userCon, false, Icons.person, Colors.orange),
            customField(
                'Password', passCon, true, Icons.key_rounded, Colors.orange),
            customField('Phone number', phoneCon, false,
                Icons.phone_android_rounded, Colors.orange),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  String username = userCon.text;
                  String email = emailCon.text;
                  String Phonenumber = phoneCon.text;
                  String passWord = passCon.text;
                  print("Username : $username ");
                  print("Email : $email ");
                  print("Phone : $Phonenumber ");
                  print("Password : $passWord ");

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 142, 50),
                        title: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 130,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Thank you for your\nregistration!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'We’re glad you’re here !\n before you start exploring, we\njust sent you the email\nconfirmation.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 238, 199, 168)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {},
                                child: Text(
                                  "Resend email confirmation",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 18),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth - 30, 60),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have account ?",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ));
                    },
                    child: const Text(
                      "Login here !",
                      style: TextStyle(color: Colors.orange),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller,
      bool obscure, IconData icon, Color color) {
    return Container(
      width: screenWidth - 35,
      margin: const EdgeInsets.only(bottom: 20),
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
