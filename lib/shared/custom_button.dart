import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../core/constant/app_color.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final double? width;
  final double? hight;
  final BorderRadiusGeometry? radius;
  final Color? col;
  final Color? textColor;
  final Widget? widget;
  final double? gap;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.hight,
    this.radius,
    this.col,
    this.textColor,
    this.widget,
    this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        width: width ?? 130,
        height: hight ?? 50,

        decoration: BoxDecoration(
          color: col ?? AppColor.prim,
          borderRadius: radius ?? BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CustomText(
              
              title: title,
              colors: textColor ?? Colors.white,
              size: 17,
              weight: FontWeight.w500,
            ),
            Gap(gap ?? 0),
            widget ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
