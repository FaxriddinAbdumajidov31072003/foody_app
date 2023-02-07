import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/product_controller.dart';

class ProductImageDialog extends StatelessWidget {
  const ProductImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Please choose'),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<ProductController>().getImageCamera();
                      },
                      icon: Icon(
                        Icons.photo_camera,
                        size: 24,
                      )),
                  IconButton(
                      onPressed: () {
                        context.read<ProductController>().getImageGallery();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.photo, size: 24)),
                ],
              );
            });
      },
      child: Image.asset(
        'assets/image/add-image.gif',
        height: 150,
        width: 150,
      ),
    );
  }
}
