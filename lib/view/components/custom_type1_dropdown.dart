import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';

class TypeDropdown extends StatelessWidget {
  const TypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: context.watch<ProductController>().listOfType.first,
      items: context
          .watch<ProductController>()
          .listOfType
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (s) {
        context.read<ProductController>().setType(s.toString());
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        labelText: "type",
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 221, 206, 206)),
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
    );
  }
}
