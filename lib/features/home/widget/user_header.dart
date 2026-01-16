import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/logo/Hungry.svg",
              color: AppColor.prim,
              width: 185,
            ),
            Gap(2),
            CustomText(
              title: "Hello, Ahmed Abdelaal",
              colors: Colors.grey.shade600,
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColor.prim,
          radius: 25,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
