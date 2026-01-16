import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/api_exceptions.dart';
import '../../cart/data/cart_model.dart';
import '../../cart/data/cart_repo.dart';
import '../../cart/view/cart_view.dart';
import '../data/topping_model.dart';
import '../data/topping_repo.dart';
import '../widget/products_add.dart';
import '../../../shared/custom_button.dart';
import '../../../shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  final String pro_img;
  final String price;
  final int productid;
  const ProductDetailsView({
    super.key,
    required this.pro_img,
    required this.price,
    required this.productid,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double val = 0.5;
  List<ToppingModel>? toppings;
  List<ToppingModel>? sideOptions;
  ToppingRepo toppingRepo = ToppingRepo();
  CartRepo cartRepo = CartRepo();
  List<int> selectedToppingIndex = [];
  List<int> selectedsideIndex = [];
  bool isloading = false;

  ///get toppings
  Future<void> getToppings() async {
    try {
      final res = await toppingRepo.getTopping();
      if (res != null && res.isNotEmpty) {
        setState(() {
          toppings = res;
        });
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///get side options
  Future<void> getSideOptions() async {
    try {
      final res = await toppingRepo.getSideoptions();
      if (res != null && res.isNotEmpty) {
        setState(() {
          sideOptions = res;
        });
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///add to cart

  @override
  void initState() {
    getToppings();
    getSideOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                children: [
                  Image.network(widget.pro_img, width: 160),
                  Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            height: 1.8,
                          ),
                          children: [
                            const TextSpan(
                              text: "Customize",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: " Your Burger\n"),
                            const TextSpan(text: "to Your Tastes. Ultimate\n"),
                            const TextSpan(text: "Experience"),
                          ],
                        ),
                      ),
                      Gap(20),
                      Container(
                        width: 140,
                        child: CustomText(
                          title: "Spicy",
                          weight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gap(5),
                      SizedBox(
                        width: 180,
                        child: Slider(
                          activeColor: AppColor.prim,

                          padding: EdgeInsets.only(left: 0, right: 40),
                          min: 0,
                          max: 1,
                          value: val,
                          onChanged: (v) {
                            setState(() {
                              val = v;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(title: "🥶", size: 11),
                            CustomText(title: "🌶️", size: 11),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///toppings
            Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 19.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: "Toppings",
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  Gap(10),
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(toppings?.length ?? 1, (index) {
                        final topping = toppings?[index];
                        final id = topping?.id;
                        final isSelected = selectedToppingIndex.contains(id);
                        if (topping == null) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: AppColor.prim,
                            ),
                          );
                        }
                        return ProductsAdd(
                          col: Colors.red,
                          icon: isSelected ? Icons.done : Icons.add,
                          img: topping.img,
                          onadd: () => setState(() {
                            if (isSelected) {
                              selectedToppingIndex.remove(id);
                            } else {
                              selectedToppingIndex.add(id!);
                            }
                          }),
                          title: topping.name,
                        );
                      }),
                    ),
                  ),
                  Gap(70),
                  CustomText(
                    title: "Side options",
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  Gap(10),
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(sideOptions?.length ?? 1, (
                        index,
                      ) {
                        final sideoption = sideOptions?[index];
                        final id = sideoption?.id;
                        final isSelected1 = selectedsideIndex.contains(id);
                        if (sideoption == null) {
                          return Center(
                            child: CupertinoActivityIndicator(
                              color: AppColor.prim,
                            ),
                          );
                        }
                        return ProductsAdd(
                          col: AppColor.prim,
                          icon: isSelected1 ? Icons.done : Icons.add,
                          img: sideoption.img,
                          onadd: () => setState(() {
                            if (isSelected1) {
                              selectedsideIndex.remove(id);
                            } else {
                              selectedsideIndex.add(id!);
                            }
                          }),
                          title: sideoption.name,
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      ///bottom sheet
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        color: AppColor.prim,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: "price", weight: FontWeight.bold, size: 17),
                Gap(7),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    children: [
                      TextSpan(
                        text: "\$",
                        style: TextStyle(color: AppColor.prim),
                      ),
                      TextSpan(
                        text: "${widget.price}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomButton(
              widget: isloading
                  ? CupertinoActivityIndicator(color: AppColor.prim)
                  : Icon(
                      Icons.add_shopping_cart_sharp,
                      size: 18,
                      color: AppColor.prim,
                    ),
              gap: 3,
              title: "Add To Cart",
              onTap: () async {
                setState(() => isloading = true);
                try {
                  final item = CartModel(
                    product_id: widget.productid,
                    qty: 1,
                    spicy: val,
                    toppings: selectedToppingIndex,
                    options: selectedsideIndex,
                  );

                  await cartRepo.addtoCart(cartRequestModel(items: [item]));
                  setState(() => isloading = false);
                } on DioError catch (e) {
                  setState(() => isloading = false);
                  throw ApiExceptions.handleError(e);
                } catch (e) {
                  setState(() => isloading = false);
                  throw ApiError(message: e.toString());
                }
              },
              col: Colors.white,
              textColor: AppColor.prim,
            ),
          ],
        ),
      ),
    );
  }
}
