import 'package:flutter/material.dart';

class CustomType extends StatefulWidget {
  const CustomType({super.key});

  @override
  State<CustomType> createState() => _CustomTypeState();
}

class _CustomTypeState extends State<CustomType> {
  String initialvalue = 'PC';
  var types = ['PC', 'KG'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      autofocus: true,
      value: initialvalue,
      items:
          types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (s) {},
      decoration: const InputDecoration(
        labelText: "Type",
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
    );
    ;
  }
}
