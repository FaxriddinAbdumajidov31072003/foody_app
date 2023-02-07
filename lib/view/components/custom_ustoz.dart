import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controller/app_controller.dart';

class CustomTextFroms extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool isObscure;
  final FocusNode? node;
  final ValueChanged<String>? onChange;
  final Color? colorBorder;
  final double radius;

  const CustomTextFroms({
    Key? key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.isObscure = false,
    this.onChange,
    this.suffixIcon, this.node, this.colorBorder, this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: node,
      obscureText:
      isObscure ? (context.watch<AppController>().isVisibility) : false,
      onChanged: onChange,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide:
            BorderSide(color: colorBorder ?? const Color(0x00000000)),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          enabledBorder: OutlineInputBorder(  borderSide:
          BorderSide(color: colorBorder ?? const Color(0x00000000)),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: colorBorder ?? const Color(0x00000000)),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          suffixIcon: suffixIcon ?? (isObscure
              ? IconButton(
            onPressed: () {
              context.read<AppController>().onChange();
            },
            icon: context.watch<AppController>().isVisibility
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          )
              : const SizedBox.shrink())),
    );
  }
}