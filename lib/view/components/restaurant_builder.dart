import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/components/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import '../style/style.dart';

class RestaurantListview extends StatelessWidget {
  const RestaurantListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(left: 24),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: ((context, index) => Container(
              margin: EdgeInsets.only(left: 10.w),
              width: (MediaQuery.of(context).size.width - 48) / 3,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 50,
                        offset: const Offset(0, 6),
                        color: const Color(0xff5A6CEA).withOpacity(0.08))
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              child: Column(
                children: [
                  24.verticalSpace,
                  context.watch<HomeController>().listOfCategory[index].image !=
                          null
                      ? CustomImageNetwork(
                          image: context
                                  .watch<HomeController>()
                                  .listOfCategory[index]
                                  .image ??
                              "",
                          height: 150,
                          width: double.infinity,
                          radius: 0,
                        )
                      : const SizedBox.shrink(),
                  24.verticalSpace,
                  Text(
                      context
                              .watch<HomeController>()
                              .listOfCategory[index]
                              .name ??
                          "",
                      style: Style.textStyleRegular(
                          size: 18, textColor: Style.blackColor)),
                  4.verticalSpace,
                ],
              ),
            )));
  }
}
