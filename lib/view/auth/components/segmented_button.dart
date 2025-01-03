import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../utils/constants.dart';


class BuildSegmentedButton extends StatelessWidget {
  const BuildSegmentedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: defPadding * 3,
        left: defPadding,
        right: defPadding,
        bottom: defPadding * 3,
      ),
      child: SizedBox(
        width: width,
        child: Obx(
              () => CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(defPadding / 2),
            groupValue: authController.segmentValue.value,
            children: {
              'phone': segmentTitle('Phone'),
              'email': segmentTitle('Email'),
              'signUp': segmentTitle('Sign up')
            },
            thumbColor: Theme.of(context).colorScheme.primary,
            onValueChanged: (value) {
              authController.clearCtrl();
              authController.segmentValue.value = value!;
            },
          ),
        ),
      ),
    );
  }
}

Widget segmentTitle(String title) {
  return Text(
    title,
    style: TextStyle(
        height: 3, fontWeight: FontWeight.w700, fontSize: height * 0.017),
  );
}
