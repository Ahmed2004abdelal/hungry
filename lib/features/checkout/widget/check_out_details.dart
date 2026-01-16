import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text.dart' show CustomText;

class CheckOutDetails extends StatelessWidget {
  final double order, taxes, Delivery, Total;
  const CheckOutDetails({
    super.key,
    required this.order,
    required this.taxes,
    required this.Delivery,
    required this.Total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: "Order summary", weight: FontWeight.bold, size: 17),
        Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              widgetDetailsOrder('Order', '\$${order}', false, false),
              Gap(10),
              widgetDetailsOrder("Taxes", '\$${taxes}', false, false),
              Gap(10),
              widgetDetailsOrder(
                "Delivery fees",
                '\$${Delivery}',
                false,
                false,
              ),
              Gap(5),
              Divider(),
              Gap(10),
              widgetDetailsOrder("Total", '\$${Total}', true, false),
              Gap(13),
              widgetDetailsOrder(
                "Estimated delivery time:",
                "15 - 30 mins",
                true,
                true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget widgetDetailsOrder(Text, price, isBold, ischSize) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        title: Text,
        size: ischSize ? 11 : 15,
        colors: isBold ? Colors.black : Colors.grey.shade600,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
      CustomText(
        title: "\$${price}",
        size: ischSize ? 11 : 15,
        colors: isBold ? Colors.black : Colors.grey.shade600,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
      ),
    ],
  );
}
