import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';

class EditPhotoProduct extends StatefulWidget {
  const EditPhotoProduct({super.key});

  @override
  State<EditPhotoProduct> createState() => _EditPhotoProductState();
}

class _EditPhotoProductState extends State<EditPhotoProduct> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            showCupertinoDialog(
                context: context,
                builder: ((context) => CupertinoAlertDialog(
                      title: Text('Choose'),
                      actions: [
                        CupertinoButton(
                            onPressed: (() async {
                              context.read<ProductController>().getImageCamera();
                            }),
                            child: Text("Take photo")),
                        CupertinoButton(
                            onPressed: (() async {
                              context.read<ProductController>().getImageGallery();
                            }),
                            child: Text("From Gallery")),
                        CupertinoButton(
                            onPressed: (() async {
                              context.read<ProductController>().deleteImage();
                              Navigator.pop(context);
                              setState(() {});
                            }),
                            child: Text('Delete')),
                        CupertinoButton(
                            onPressed: (() async {
                              Navigator.pop(context);
                            }),
                            child: Text('Cancel'))
                      ],
                    )));
          },
          child: Container(
            height: 55.h,
            width: 55.w,
            decoration: BoxDecoration(
              color: Color(0xffF43F5E),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8.r),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ));
  }
}