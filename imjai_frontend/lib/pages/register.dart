import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
        padding:
            const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(
                            255, 237, 158, 2)), // <-- Button color
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)){
                          return Colors.red;
                        }
                         // <-- Splash color
                    }),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "images/Imjai_Logo.png",
              width: 200,
              height: 200,
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
            customFieldEmail(
                'Email', emailCon, false, Icons.email, Colors.orange),
            customFieldEmail(
                'Username', userCon, false, Icons.person, Colors.orange),
            customFieldEmail(
                'Password', passCon, true, Icons.key_rounded, Colors.orange),
            customFieldEmail('Phone number', phoneCon, false,
                Icons.phone_android_rounded, Colors.orange),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {},
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
                const Text("Already have account ?", style: TextStyle(color: Colors.grey),),
                TextButton(onPressed: () {}, child: const Text("Login here !", style: TextStyle(color: Colors.orange),)
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customFieldEmail(String hint, TextEditingController controller,
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
        ]
      ),
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
