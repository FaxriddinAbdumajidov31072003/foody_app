import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/pages/home/general_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';
import '../pages/home/home_page.dart';
import '../style/style.dart';

class FacebookandGoogle extends StatelessWidget {
  const FacebookandGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () async {
            context.read<AuthController>().loginFacebook(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const GeneralPage()),
                  (route) => false);
            });
          },
          child: Container(
            child: Row(
              children: [
                37.5.horizontalSpace,
                Image.asset(
                  'assets/image/facebook.png',
                  height: 25,
                  width: 25,
                ),
                12.horizontalSpace,
                context.watch<AuthController>().isFacebookLoading
                    ? Padding(
                        padding: EdgeInsets.all(2.0),
                        child: LoadingAnimationWidget.inkDrop(
                          color: Style.primaryColor,
                          size: 24,
                        ),
                      )
                    : Text(
                        'Facebook',
                        style: Style.textStyleRegular2(
                            textColor: Style.blackColor),
                      ),
              ],
            ),
            height: 57.h,
            width: 178.w,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 221, 206, 206)),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
          ),
        ),
        GestureDetector(
          onTap: () async {
            context.read<AuthController>().loginGoogle(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const GeneralPage()),
                  (route) => false);
            });
          },
          child: Container(
            height: 57.h,
            width: 178.w,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 221, 206, 206)),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Row(
              children: [
                37.5.horizontalSpace,
                Image.asset(
                  'assets/image/google.png',
                  height: 25,
                  width: 24,
                ),
                12.horizontalSpace,
                context.watch<AuthController>().isGoogleLoading
                    ? Padding(
                        padding: EdgeInsets.all(2.0),
                        child: LoadingAnimationWidget.inkDrop(
                            color: Style.primaryColor, size: 24),
                      )
                    : Text(
                        'Google',
                        style: Style.textStyleRegular2(
                            textColor: Style.blackColor),
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
