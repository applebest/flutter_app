import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterwg/pages/cart_page.dart';
import 'package:flutterwg/pages/category_page.dart';
import 'package:flutterwg/pages/home_page.dart';
import 'package:flutterwg/pages/member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/current_index.dart';


class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: "分类"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: "购物车"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: "会员中心")
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        orientation: Orientation.portrait);

    return Consumer<CurrentIndexProvider>(builder: (context, value, child) {
      int currentIndex =
          Provider.of<CurrentIndexProvider>(context, listen: false)
              .currentIndex;

      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: bottomTabs,
          onTap: (index) {
            Provider.of<CurrentIndexProvider>(context, listen: false)
                .changeIndex(index);
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: tabBodies,
        ),
      );
    });
  }
}
