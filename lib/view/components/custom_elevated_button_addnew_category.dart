import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../controller/product_controller.dart';
import 'custom_textform.dart';
import 'edit_photo_category.dart';


class CustomNewCategory extends StatefulWidget {
  const CustomNewCategory({super.key});

  @override
  State<CustomNewCategory> createState() => _CustomNewCategoryState();
}

class _CustomNewCategoryState extends State<CustomNewCategory> {
  final TextEditingController newCategoryTextEditController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: context
                          .watch<ProductController>()
                          .imagePathofCategory
                          .isEmpty
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductController>()
                                      .getImageCamerafromCategory();
                                },
                                icon: Icon(
                                  Icons.photo_camera,
                                  size: 24,
                                )),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<ProductController>()
                                      .getImageGalleryfromCategory();
                                },
                                icon: Icon(Icons.photo, size: 24)),
                          ],
                        )
                      : const SizedBox.shrink(),
                  title: CustomTextFrom(
                    label: "New Category",
                    controller: newCategoryTextEditController,
                    hintext: '',

                  ),
                  actions: [
                    context
                            .watch<ProductController>()
                            .imagePathofCategory
                            .isEmpty
                        ? const SizedBox.shrink()
                        : Stack(
                            children: [
                              Container(
                                width: 160,
                                height: 160.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(context
                                            .watch<ProductController>()
                                            .imagePathofCategory),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              EditCategoryPhoto()
                            ],
                          ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ProductController>().addCategory(
                                name: newCategoryTextEditController.text
                                    .toLowerCase(),
                                onSuccess: () {
                                  context
                                      .read<ProductController>()
                                      .getCategory();
                                },
                              );
                          Navigator.pop(context);
                        },
                        child:
                            context.watch<ProductController>().isCategoryLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text("Save"))
                  ],
                );
              });
        },
        child: Text("Add Category"));
  }
}
