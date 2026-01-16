import 'package:flutter/material.dart';

import '../../../core/constant/app_color.dart';
import '../../../shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({super.key, this.onTap, required this.text, this.color, this.textColor, this.width});
  final Function() ? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: color ??  Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: Colors.grey,
            ),
        ),
        width: width ?? double.infinity,
        child: Center(child: CustomText(
          title: text,
          size: 15,
          weight: FontWeight.w600,
          colors: textColor ??  AppColor.prim,
        )),
      ),
    );
  }
}