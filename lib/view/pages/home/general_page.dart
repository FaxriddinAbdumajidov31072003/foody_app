import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/pages/home/chats_page.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:provider/provider.dart';

import '../../../controller/auth_controller.dart';
import '../product/add_product_page.dart';
import 'home_page.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  List<Widget> mainPages = [
    const HomePage(),
    const Placeholder(),
    const AddProductPage(),
    const ChatsPage(),
    const Placeholder(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<AuthController>().currentIndex,
        children: mainPages,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        child: BottomNavyBar(
          selectedIndex: context.watch<AuthController>().currentIndex,
          // showElevation: true,
          backgroundColor: Colors.white,
          containerHeight: 70,
          itemCornerRadius: 12,
          curve: Curves.easeIn,
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                activeColor: Style.primaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.shopping_basket),
                title: const Text('Order'),
                activeColor: Style.primaryColor),
            BottomNavyBarItem(
                icon: const Icon(
                  Icons.add_circle_outline_sharp,
                ),
                title: const Text('Add Product'),
                activeColor: Style.primaryColor),
            BottomNavyBarItem(
                icon: const Icon(Icons.message),
                title: const Text('Chat'),
                activeColor: Style.primaryColor),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              activeColor: Style.primaryColor,
            )
          ],
          onItemSelected: (value) {
            context.read<AuthController>().setIndex(value);
          },
        ),
      ),
    );
  }
}
