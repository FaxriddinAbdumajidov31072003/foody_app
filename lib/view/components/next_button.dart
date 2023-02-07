import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';
import '../style/style.dart';

class NextButton extends StatelessWidget {
  final String image;
  const NextButton({super.key, required this.image});

  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 130),
      decoration: BoxDecoration(
        color: image.isEmpty
            ? const Color.fromARGB(244, 235, 134, 164)
            : const Color(0xffFF1843),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
      ),
      child: Center(
        child: context.watch<AuthController>().isLoading
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: LoadingAnimationWidget.inkDrop(
                    color: Style.whiteColor, size: 35),
              )
            : Text('Next',
                style: Style.textStyleRegular(textColor: Style.whiteColor)),
      ),
    );
    
  }
}
