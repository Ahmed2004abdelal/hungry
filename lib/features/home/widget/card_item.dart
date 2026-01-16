import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  final String img, title, desc, rate;
  const CardItem({
    super.key,
    required this.img,
    required this.title,
    required this.desc,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      // padding: EdgeInsets.zero,
      // margin: const EdgeInsets.only(right: 15),

      // elevation: 8,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,

      child: Container(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade200,
              Colors.grey.shade300,
              Colors.grey.shade500,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                img,
                width: 150,
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
            CustomText(
              title: title,
              weight: FontWeight.w700,
              colors: AppColor.prim,
              size: 13,
            ),
            CustomText(title: desc, size: 9),
            Gap(9),
            Row(
              children: [
                CustomText(title: "⭐ ${rate}"),
                Spacer(),
                Icon(CupertinoIcons.heart, color: AppColor.prim),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
