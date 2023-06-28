import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:imjai_frontend/pages/caller.dart';
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
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController bdate = TextEditingController();
  String birthDateInString = "";
  DateTime? birthDate;
  double screenHeight = 0;
  double screenWidth = 0;
  int userId = 0;
  Color primary = Color.fromARGB(255, 255, 255, 255);
  void getDatetime() async {
    final datePick = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime(2100));
    if (datePick != null && datePick != birthDate) {
      setState(() {
        birthDate = datePick;
        print(birthDate);
        // put it here
        birthDateInString =
            "${birthDate?.day}/${birthDate?.month}/${birthDate?.year}"; // 08/14/2019
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    saveInfo() async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (emailCon.text == "" ||
              userCon.text == "" ||
              passCon.text == "" ||
              phoneCon.text == "" ||
              fname.text == "" ||
              lname.text == ""
          // bdate.text == ""
          ) {
        print("found null");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please fill in all information!"),
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
          Response register = await Caller.dio.post(
            "/verifySignup",
            data: {
              "email": emailCon.text,
              "username": userCon.text,
              "password": passCon.text,
              "phone_number": phoneCon.text,
              "firstname": fname.text,
              "lastname": lname.text,
              "birthdate": birthDate.toString()
            },
          );
          print(register.data);
          userId = register.data['id'];
          print("this is userId");
          print(userId);

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
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 255, 255)),
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
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
                actions: [
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 238, 199, 168)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () async {
                              try {
                                Response resendEmail = await Caller.dio.get(
                                  "/resendEmail",
                                  data: {
                                    "userId": userId,
                                  },
                                );
                                print(resendEmail.data);
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text(
                              "Resend email confirmation",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            )),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => Login())));
                            },
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // )
                ],
              );
            },
          );
        } catch (e) {
          print(e);
          if (e is DioError) {
            if (e.response?.statusCode == 400) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("User already in use!"),
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
            } else if (e.response?.statusCode == 401) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Email already in use!"),
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
            } else if (e.response?.statusCode == 500) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Unable to validate username!"),
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

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              color: primary,
              child: Row(
                children: <Widget>[
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
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight / 35),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            // // Image.asset(
            // //   'Images/ImJai Logo.png', // Replace with your logo image path
            // //   width: 90,
            // //   height: 90,
            // // ),
            // const SizedBox(
            //   height: 30,
            // ),
            // Text(
            //   "REGISTER",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold, fontSize: screenWidth / 20),
            // ),
            const SizedBox(
              height: 20,
            ),
            customField(
                'Email', emailCon, false, Icons.email, Colors.orange, null),
            customField(
                'Username', userCon, false, Icons.person, Colors.orange, null),
            customField('Password', passCon, true, Icons.key_rounded,
                Colors.orange, null),
            customField(
                'First Name', fname, false, Icons.person, Colors.orange, null),
            customField(
                'Last Name', lname, false, Icons.person, Colors.orange, null),
            customField(
                birthDateInString == "" ? "BirthDate" : birthDateInString,
                bdate,
                false,
                Icons.calendar_month_rounded,
                Colors.orange,
                getDatetime),
            customField('Phone number', phoneCon, false,
                Icons.phone_android_rounded, Colors.orange, null),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  String username = userCon.text;
                  String email = emailCon.text;
                  String firstname = fname.text;
                  String lastname = lname.text;
                  String Phonenumber = phoneCon.text;
                  String birthdate = birthDate.toString();
                  String passWord = passCon.text;
                  print("Username : $username ");
                  print("Email : $email ");
                  print("Fname : $firstname ");
                  print("Lname : $lastname ");
                  print("Bdate : $birthdate ");
                  print("Phone : $Phonenumber ");
                  print("Password : $passWord ");
                  await saveInfo();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth - 30, 50),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
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
                    child: Text(
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
      bool obscure, IconData icon, Color color, void Function()? ff) {
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
                onTap: ff,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight / 45,
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
