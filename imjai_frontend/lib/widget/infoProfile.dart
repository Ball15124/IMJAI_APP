import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  String title;
  String data;
  bool enable;
  TextEditingController? controller;
  Color? color;
  TextInputType? text;

  Info(
      {Key? key,
      required this.title,
      required this.data,
      required this.enable,
      this.color,
      this.controller,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        TextField(
          decoration: InputDecoration(
              labelText: data,
              labelStyle: TextStyle(
                color: color,
              )),
          enabled: enable,
          controller: controller,
          keyboardType: text,
          style: TextStyle(
            color: color,
          ),
        )
      ],
    );
  }
}
