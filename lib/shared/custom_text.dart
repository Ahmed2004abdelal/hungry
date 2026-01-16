import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? size;
  final FontWeight? weight;
  final Color? colors;
  final TextAlign? textAlign;
  const CustomText({
    super.key,
    required this.title,
    this.size,
    this.weight,
    this.colors,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      
      maxLines: 2,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight, 
        color: colors),
    );
  }
}
