import 'package:flutter/material.dart';
import 'package:foody_app/view/style/style.dart';

class CkeckBox extends StatefulWidget {
  const CkeckBox({super.key});

  @override
  State<CkeckBox> createState() => _CkeckBoxState();
}

class _CkeckBoxState extends State<CkeckBox> {
  @override

   bool value = false;

  Widget build(BuildContext context) {
    return Row(
                children: [
                  Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) => const BorderSide(
                          width: 1.0,
                          color: Color(0xffFF1843),
                        ),
                      ),
                      activeColor: const Color(0xffFF1843),
                      value: this.value,
                      onChanged: ((value) {
                        setState(() {
                          this.value = value!;
                        });
                      })),
                  Text(
                    'Remember me',
                    style:Style.textStyleRegular2(size: 14,textColor: Color(0xff2C3A4B))
                  ),
                ],
              );
  }
}