import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';

class GenderChoosing extends StatefulWidget {
  const GenderChoosing({super.key});

  @override
  State<GenderChoosing> createState() => _GenderChoosingState();
}

class _GenderChoosingState extends State<GenderChoosing> {
  var items = ['Male', 'Female'];
  String initialvalue = 'Male';
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
      child: DropdownButtonFormField(
        icon: SvgPicture.asset(
          'assets/svg/arrowdown.svg',
          color: Colors.grey,
        ),
        value: initialvalue,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xffDADEE3)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
        items: items
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        onChanged: (newValue) {
          value = newValue!;
          context.read<AuthController>().setgender(value);
          setState(() {});
        },
      ),
    );
  }
}
