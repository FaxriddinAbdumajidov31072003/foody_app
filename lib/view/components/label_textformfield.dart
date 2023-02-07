import 'package:flutter/material.dart';
import 'package:foody_app/view/style/style.dart';

class Label extends StatelessWidget {
  final String text;
  const Label({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: Style.textStyleRegular2(textColor: const Color(0xff2C3A4B))),
        Text('*',
            style: Style.textStyleRegular2(
                size: 14, textColor: Style.primaryColor)),
      ],
    );
  }
}
