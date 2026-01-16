import 'package:flutter/material.dart';

import '../../../shared/custom_text.dart';

class ProductsAdd extends StatelessWidget {
  final VoidCallback onadd;
  final img, title;
  final IconData icon;
  final Color col;
  const ProductsAdd({
    super.key,
    this.img,
    this.title,
    required this.col,
    required this.icon, 
    required this.onadd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onadd,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 33,
              child: Container(
                width: 85,
                height: 69,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff3C2F2F),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              width: 85,
              height: 61,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(
                // "assets/details/tomato.png",
                img,
                // fit: BoxFit.contain,
                width: 2,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 67,
              left: 5,
              right: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: title, size: 12, colors: Colors.white),
                  // Spacer(),
                  CircleAvatar(
                    radius: 10,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 17,
                      weight: 20.0,
                    ),
                    backgroundColor: col,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
