import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constant/app_color.dart';
import '../../product/view/product_details_view.dart';
import '../data/product_model.dart';
import '../data/product_repo.dart';
import '../widget/card_item.dart';
import '../widget/food_category.dart';
import '../widget/search_field.dart';
import '../widget/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> category = ["All", "Combo", "Sliders", "Classic"];
  int selected_catg = 0;
  ProductRepo productRepo = ProductRepo();
  List<ProductModel>? products;

  /// get product
  Future<void> getproduct() async {
    final res = await productRepo.getproduct();
    if (!mounted) return;
    setState(() {
      products = res;
    });
  }

  @override
  void initState() {
    getproduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  // pinned: true,
                  floating: true,
                  scrolledUnderElevation: 0,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 150,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: EdgeInsetsGeometry.only(
                      right: 20,
                      left: 20,
                      top: 5,
                      bottom: 0,
                    ),
                    child: Column(
                      children: [
                        Gap(10),

                        ///headers...
                        UserHeader(),
                        Gap(20),

                        ///serachBar...
                        SearchField(),
                        // Gap(10),
                      ],
                    ),
                  ),
                ),
                // CircularProgressIndicator()
                ///appbar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: ClipPath(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Gap(10),

                          ///category...
                          FoodCategory(
                            category: category,
                            selected_catg: selected_catg,
                          ),
                          Gap(10),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products?[index];

                      if (product == null) {
                        return CupertinoActivityIndicator(color: AppColor.prim);
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => ProductDetailsView(
                                pro_img: product.image,
                                productid: product.id,
                                price: product.price,
                              ),
                            ),
                          );
                        },
                        child: CardItem(
                          img: product.image,
                          title: product.name,
                          desc: product.desc,
                          rate: product.rating,
                        ),
                      );
                    }, childCount: products?.length ?? 6),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 5,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
