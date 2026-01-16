import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'core/constant/app_color.dart';
import 'features/auth/view/profile_view.dart';
import 'features/cart/view/cart_view.dart';
import 'features/home/view/home_view.dart';
import 'features/orderHistory/views/orderHistory.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentpage = 0;

  final List<Widget> pages = [
    HomeView(),
    CartView(),
    Orderhistoryview(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentpage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentpage,
        onTap: (index) {
          setState(() => currentpage = index);
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColor.prim,
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_restaurant),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
