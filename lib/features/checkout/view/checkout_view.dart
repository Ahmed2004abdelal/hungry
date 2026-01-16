import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_color.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';
import '../widget/check_out_details.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selected = 'cash';
  bool ischeck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            CheckOutDetails(
              order: 23.4,
              taxes: 23.4,
              Delivery: 23.4,
              Total: 23.4,
            ),
            const Gap(50),
            const CustomText(
              title: "Payment methods",
              weight: FontWeight.bold,
              size: 17,
            ),
            const Gap(20),
            Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              elevation: 6,
              child: ListTile(
                onTap: () => setState(() => selected = 'cash'),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 9,
                ),
                tileColor: const Color(0xff3C2F2F),
                leading: Image.asset("assets/icon/dollar_icon.png", width: 50),
                title: const CustomText(
                  title: "Cash on Delivery",
                  colors: Colors.white,
                  weight: FontWeight.w500,
                  size: 17,
                ),
                trailing: Radio(
                  activeColor: Colors.white,
                  value: 'cash',
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v!),
                ),
              ),
            ),
            const Gap(20),
            Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.grey,
              elevation: 6,
              child: ListTile(
                onTap: () => setState(() => selected = 'Debit'),
                tileColor: const Color(0xffF3F4F6),
                leading: Image.asset("assets/icon/visa.png", width: 50),
                title: const CustomText(
                  title: "Debit card",
                  colors: Colors.black,
                  size: 11,
                  weight: FontWeight.w400,
                ),
                subtitle: const CustomText(
                  title: '3566 **** **** 0505',
                  size: 11,
                  weight: FontWeight.w400,
                  colors: Colors.grey,
                ),
                trailing: Radio(
                  activeColor: Colors.white,
                  value: 'Debit',
                  groupValue: selected,
                  onChanged: (v) => setState(() => selected = v!),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.red,
                  value: ischeck,
                  onChanged: (v) => setState(() => ischeck = !ischeck),
                ),
                CustomText(
                  title: 'Save card details for future payments',
                  colors: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.only(top: 20, left: 13, right: 13),
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: "Total price",
                  weight: FontWeight.w400,
                  size: 14,
                  colors: Colors.grey.shade600,
                ),
                const Gap(7),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    children: [
                      TextSpan(
                        text: "\$",
                        style: TextStyle(color: AppColor.prim),
                      ),
                      const TextSpan(
                        text: "18.19",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomButton(
              title: "Add To Cart",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      // backgroundColor: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        height: 350,
                        width: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 50,
                              ),
                              backgroundColor: AppColor.prim,
                            ),
                            Gap(23),
                            CustomText(
                              title: "Success !",
                              weight: FontWeight.w900,
                              size: 30,
                              colors: AppColor.prim,
                            ),
                            Gap(6),
                            CustomText(
                              textAlign: TextAlign.center,
                              title:
                                  "Your payment was successful.\nA receipt for this purchase has\nbeen sent to your email.",
                              // weight: FontWeight.w900,
                              size: 12,
                              colors: Colors.grey.shade500,
                            ),
                            Gap(40),
                            CustomButton(
                              title: "Go Back",
                              onTap: () => Navigator.pop(context),
                              width: double.infinity,
                              hight: 55,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
