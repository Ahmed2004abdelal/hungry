import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../data/cart_model.dart';
import '../data/cart_repo.dart';
import '../widget/cart_card.dart';
import '../../checkout/view/checkout_view.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

///
///
///maintane total price
///
///

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int itemCount = 20;
  late List<int> qun;
  GetCartResponse? cartResponse;
  double totalPrice = 0.0;

  ///get cart data
  CartRepo _cartRepo = CartRepo();

  ///calculate total price
  void calculateTotalPrice() {
    double total = 0.0;
    if (cartResponse != null) {
      for (var item in cartResponse!.cartdata.cartItems) {
        total += double.parse(item.price) * item.qty;
      }
    }
    setState(() {
      totalPrice = total;
    });
  }

  ///fetch cart data
  Future<void> getCartData() async {
    final res = await _cartRepo.getCartData();
    setState(() {
      cartResponse = res;
    });
    calculateTotalPrice();
  }

  ///delete item from cart
  Future<void> removeItemFromCart(int itemId) async {
    try {
      await _cartRepo.removeFromCart(itemId);
      getCartData();
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  @override
  void initState() {
    qun = List.generate(itemCount, (index) => 1);
    getCartData();
    super.initState();
  }

  void onadd(int index) {
    setState(() {
      qun[index]++;
    });
  }

  void onmin(int index) {
    if (qun[index] > 1)
      setState(() {
        qun[index]--;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: getCartData,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100),
                    itemCount: cartResponse?.cartdata.cartItems.length ?? 1,
                    itemBuilder: (context, index) {
                      final item = cartResponse?.cartdata.cartItems[index];
                      if (item == null) {
                        return Container(
                          height: 500,
                          alignment: Alignment.center,
                          child: Center(
                            child: CupertinoActivityIndicator(
                              color: AppColor.prim,
                              radius: 30,
                            ),
                          ),
                        );
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: CartCard(
                          img: item!.img,
                          title: item.name,
                          desc: "\$ ${item.price.toString()}",
                          num: item.qty,
                          onadd: () => onadd(index),
                          onminus: () => onmin(index),
                          onremove: () => removeItemFromCart(item!.itemId),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        ///bottom
        bottomSheet: Container(
          color: Colors.white,
          height: 100,
          padding: EdgeInsets.fromLTRB(16, 13, 13, 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: "Total", weight: FontWeight.bold, size: 17),
                  Gap(7),
                  cartResponse?.cartdata.totalPrice == null
                      ? CupertinoActivityIndicator()
                      : RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            children: [
                              TextSpan(
                                text: "\$",
                                style: TextStyle(color: AppColor.prim),
                              ),
                              TextSpan(
                                text: "${totalPrice}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              CustomButton(
                title: "Checkout",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => CheckoutView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
