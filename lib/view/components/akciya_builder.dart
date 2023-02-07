import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import '../style/style.dart';
import 'cached_network_image.dart';

class AkciyaListView extends StatelessWidget {
  const AkciyaListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 12),
        scrollDirection: Axis.horizontal,
        itemCount: context.watch<HomeController>().listOfBanners.length,
        itemBuilder: ((context, index) => Container(
              margin: EdgeInsets.only(right: 15),
              height: 180.h,
              width: 410.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                  gradient: Style.linearGradient),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  14.verticalSpace,
                  context
                              .watch<HomeController>()
                              .listOfBanners[index]
                              .product
                              .image !=
                          null
                      ? CustomImageNetwork(
                          image: context
                                  .watch<HomeController>()
                                  .listOfBanners[index]
                                  .product
                                  .image ??
                              "",
                          height: double.infinity,
                          width: 155,
                        )
                      : const SizedBox.shrink(),
                  15.horizontalSpace,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      30.verticalSpace,
                      Text(
                          context
                              .watch<HomeController>()
                              .listOfBanners[index]
                              .title,
                          style: Style.textStyleRegular(
                              size: 23, textColor: Style.whiteColor)),
                      Text(
                          context
                                  .watch<HomeController>()
                                  .listOfBanners[index]
                                  .product
                                  .desc ??
                              "",
                          style: Style.textStyleRegular(
                              size: 20, textColor: Style.whiteColor)),
                      14.verticalSpace,
                      Container(
                        width: 120.w,
                        height: 37.h,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(32))),
                        child: Center(
                          child: Text('Buy Now',
                              style: Style.textStyleRegular(
                                  size: 14, textColor: Style.whiteColor)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
