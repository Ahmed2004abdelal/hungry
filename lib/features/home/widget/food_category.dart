import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/app_color.dart';
import '../../../shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  final int selected_catg;
  final List category;
  const FoodCategory({
    super.key,
    required this.selected_catg,
    required this.category,
  });

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int selectedCatg;
  @override
  void initState() {
    selectedCatg = widget.selected_catg;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCatg = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: selectedCatg == index
                    ? AppColor.prim
                    : Colors.grey.shade200,
              ),
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 15),
              child: CustomText(
                title: "${widget.category[index]}",
                weight: FontWeight.w600,
                colors: selectedCatg == index
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
            ),
          );
        }),
      ),
    );
  }
}
