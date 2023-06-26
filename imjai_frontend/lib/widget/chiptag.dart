import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChipTag extends StatefulWidget {
  const ChipTag({super.key});

  @override
  State<ChipTag> createState() => _ChipTagState();
}

class _ChipTagState extends State<ChipTag> {
  int tag = 1;
  List<String> tags = [];
  List<String> options = [
    'Meat',
    'Veget&Fruit',
    'Food',
    'Flavoring',
    'Drink',
    'Snack',
    'Dessert',
    'Food Waste'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ChipsChoice.single(
            value: tag,
            onChanged: (val) async {
              setState(() {
                tag = val;
              });
              SharedPreferences productTag =
                  await SharedPreferences.getInstance();
              await productTag.setInt('tag', tag + 1);
              int proTag = productTag.getInt('tag')!;
              print(proTag);
            },
            choiceItems: C2Choice.listFrom(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
              // disabled: (i, v) => [0, 2, 5].contains(i),
            ),
            choiceActiveStyle: const C2ChoiceStyle(
              color: Colors.orange,
              borderColor: Colors.orange,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            choiceStyle: const C2ChoiceStyle(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            wrapped: true,
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }
}
