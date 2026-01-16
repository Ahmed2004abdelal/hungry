import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class Orderhistoryview extends StatelessWidget {
  const Orderhistoryview({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 100),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      top: 10,
                                    ),
                                    child: Image.asset(
                                      "assets/test/test.png",
                                      width: 80,
                                    ),
                                  ),
                                  Gap(25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: "cheese burger",
                                        weight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        title: "QTY : X3",
                                        weight: FontWeight.w400,
                                      ),
                                      CustomText(
                                        title: "Price : 20\$",
                                        weight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gap(15),
                              CustomButton(
                                title: "Order Again",
                                onTap: () {},
                                width: double.infinity,
                                hight: 50,
                                radius: BorderRadius.circular(17),
                                col: Colors.grey.shade400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
