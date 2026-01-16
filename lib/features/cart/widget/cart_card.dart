import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../shared/custom_text.dart';

class CartCard extends StatefulWidget {
  final String img, title, desc;
  final Function()? onadd;
  final Function()? onminus;
  final Function()? onremove;
  final int num;

  const CartCard({
    super.key,
    required this.img,
    required this.title,
    required this.desc,
    this.onadd,
    this.onminus,
    this.onremove,
    required this.num,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shadowColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.img, width: 80),
                  CustomText(
                    title: widget.title,
                    weight: FontWeight.bold,
                    size: 11,
                  ),
                  CustomText(title: widget.desc, weight: FontWeight.w400),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onminus,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.prim,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            size: 20,
                            CupertinoIcons.minus,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Gap(25),
                    CustomText(title: "${widget.num}"),
                    Gap(25),
                    GestureDetector(
                      onTap: widget.onadd,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.prim,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            size: 20,
                            CupertinoIcons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Gap(35),
                GestureDetector(
                  onTap: widget.onremove,
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColor.prim,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: CustomText(
                      title: "Remove",
                      weight: FontWeight.w500,
                      size: 15,
                      colors: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
