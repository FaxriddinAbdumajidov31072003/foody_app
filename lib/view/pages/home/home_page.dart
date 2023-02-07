import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/custom_textform.dart';
import 'package:foody_app/view/pages/auth/sign_in.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../controller/user_controller.dart';
import '../../components/akciya_builder.dart';
import '../../components/cached_network_image.dart';
import '../../components/popular_menu_builder.dart';
import '../../components/restaurant_builder.dart';
import '../../components/search_filter.dart';
import 'all_categories.dart';
import 'all_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserController>().getUser();
      context.read<HomeController>()
        ..getBanners()
        ..getProduct()
        ..getCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/image/Group.png'))),
        child: Scaffold(
          body: context.watch<HomeController>().isTotalLoading
              ? Center(child: const CircularProgressIndicator())
              : SafeArea(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            24.horizontalSpace,
                            CustomImageNetwork(
                                radius: 100,
                                height: 60.h,
                                width: 60.w,
                                image:
                                    '${context.watch<UserController>().user?.avatar ?? ""}'),
                            24.horizontalSpace,
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Text('Hello👋',
                                        style:
                                            Style.textStyleRegular(size: 19)),
                                    Text(
                                        overflow: TextOverflow.visible,
                                        maxLines: 1,
                                        softWrap: false,
                                        context
                                                .watch<UserController>()
                                                .user
                                                ?.username ??
                                            '',
                                        style:
                                            Style.textStyleRegular(size: 19)),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xffF6F8FB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: const Icon(
                                  Icons.notifications_active,
                                  color: Color(0xffF43F5E),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<UserController>().logOut(() {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const SignInPage()),
                                        (route) => false);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffF6F8FB),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: const Icon(
                                    Icons.logout_outlined,
                                    color: Color(0xffF43F5E),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        32.verticalSpace,
                        SearchFilter(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                32.verticalSpace,
                                const SizedBox(
                                    height: 185, child: AkciyaListView()),
                                32.verticalSpace,
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: Text('Popular Categories',
                                          style: Style.textStyleRegular(
                                              size: 20,
                                              textColor: Style.blackColor)),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      CategoryPage())));
                                        },
                                        child: Text('See all',
                                            style: Style.textStyleRegular(
                                                size: 16,
                                                textColor: Style.primaryColor)),
                                      ),
                                    ),
                                  ],
                                ),
                                32.verticalSpace,
                                SizedBox(
                                    height: 280.h,
                                    child: const RestaurantListview()),
                                32.verticalSpace,
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: Text('Popular Products',
                                          style:
                                              Style.textStyleRegular(size: 20)),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ProductListPage())));
                                        },
                                        child: Text('See all',
                                            style: Style.textStyleRegular2(
                                                textColor: Style.primaryColor)),
                                      ),
                                    ),
                                  ],
                                ),
                                32.verticalSpace,
                                const MenuListView(),
                                100.verticalSpace,
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
