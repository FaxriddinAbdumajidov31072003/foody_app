import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_app/view/style/diss_keyboard.dart';
import 'package:foody_app/view/style/style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:progress_loading_button/progress_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../controller/auth_controller.dart';
import 'fill_bio.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OnUnFocusTap(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.18, vertical: 8.18),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9.82)),
                            color: Color.fromARGB(255, 234, 175, 194)),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffF43F5E),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text('Verification',
                          style: Style.textStyleRegular(size: 26)),
                    )
                  ],
                ),
              ),
              150.verticalSpace,
              Text(
                  'Code has been send to ${context.watch<AuthController>().phone}'),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: PinFieldAutoFill(
                  autoFocus: true,
                  controller: controller,
                  cursor: Cursor(
                      color: Colors.black,
                      enabled: true,
                      width: 3,
                      radius: Radius.circular(24)),
                  decoration: BoxLooseDecoration(
                    gapSpace: 10,
                    bgColorBuilder: FixedColorBuilder(
                      Colors.white,
                    ),
                    strokeColorBuilder: FixedColorBuilder(
                      Colors.black,
                    ),
                  ),
                  onCodeSubmitted: (s) {},
                  onCodeChanged: (s) {},
                  currentCode: "",
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Style.primaryDisabledColor)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  onPressed: () {
                    context.read<AuthController>().checkCode(controller.text, () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const FillBioPage()),
                          (route) => false);
                    });
                  },
                  child: context.watch<AuthController>().isLoading
                      ? Padding(
                          padding: EdgeInsets.all(2.0),
                          child: LoadingAnimationWidget.inkDrop(
                              color: Style.whiteColor, size: 24),
                        )
                      : const Text("Check"))
            ],
          ),
        ),
      ),
    );
  }
}
