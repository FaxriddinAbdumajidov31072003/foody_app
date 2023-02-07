import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/model/category_model.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/product_model.dart';

class ProductController extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List listOfCategory = [];
  List listOfType = ["KG", "PC"];
  int selectCategoryIndex = 0;
  int selectTypeIndex = 0;
  bool isLoading = true;
  bool isSaveLoading = false;
  bool isCategoryLoading = false;
  QuerySnapshot? res;
  String imagePath = "";
  String imagePathofCategory = "";
  final ImagePicker _image = ImagePicker();
  final ImagePicker _imageCategory = ImagePicker();
  

  getCategory() async {
    isLoading = true;
    notifyListeners();
    res = await firestore.collection("category").get();
    listOfCategory.clear();
    res?.docs.forEach((element) {
      listOfCategory.add(element["name"]);
    });
    isLoading = false;
    notifyListeners();
  }

  setCategory(String category) {
    selectCategoryIndex = listOfCategory.indexOf(category);
    notifyListeners();
  }

  setType(String type) {
    selectTypeIndex = listOfType.indexOf(type);
    notifyListeners();
  }

  createProduct(
      {required String name,
      required String desc,
      required String price}) async {
    isSaveLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("products/${DateTime.now().toString()}");
    await storageRef.putFile(File(imagePath));

    String url = await storageRef.getDownloadURL();

    await firestore.collection("products").add(ProductModel(
            name: name,
            desc: desc,
            image: url,
            price: double.tryParse(price) ?? 0,
            category: res?.docs[selectCategoryIndex].id,
            type: listOfType[selectTypeIndex],isLike: false)
        .toJson());

    isSaveLoading = false;
    notifyListeners();
  }

  addCategory({
    required String name,
    required VoidCallback onSuccess,
  }) async {
    bool isCategoryLoading = true;
    notifyListeners();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child("CategoryImages/${DateTime.now().toString()}");
    await storageRef.putFile(File(imagePath));

    String url = await storageRef.getDownloadURL();

    await firestore
        .collection("category")
        .add(CategoryModel(name: name, image: url).toJson());
    isCategoryLoading = false;
    notifyListeners();
    onSuccess();
  }

  getImageCamera() {
    _image.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getImageGallery() {
    _image.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePath = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  deleteImage() {
    imagePath = '';
    notifyListeners();
  }

  getImageGalleryfromCategory() {
    _imageCategory.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePathofCategory = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  getImageCamerafromCategory() {
    _imageCategory.pickImage(source: ImageSource.camera).then((value) async {
      if (value != null) {
        CroppedFile? cropperImage =
            await ImageCropper().cropImage(sourcePath: value.path);
        imagePathofCategory = cropperImage?.path ?? "";
        notifyListeners();
      }
    });
    notifyListeners();
  }

  deleteImagefromCategory() {
    imagePathofCategory = '';
    notifyListeners();
  }
}
