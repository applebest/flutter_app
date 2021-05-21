import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/cart.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'package:flutterwg/provide/current_index.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<DetailsInfoProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var goodsCount = 1;
    var goodsPrice = goodsInfo.presentPrice;
    var image = goodsInfo.image1;

    return Container(
      width: 750.w,
      color: Colors.white,
      height: 80.h,
      child: Row(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Provider.of<CurrentIndexProvider>(context, listen: false)
                      .changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 110.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  int goodsCount =
                      Provider.of<CartProvider>(context, listen: false)
                          .allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "$goodsCount",
                        style: TextStyle(color: Colors.white, fontSize: 22.sp),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false)
                  .save(goodsId, goodsName, goodsCount, goodsPrice, image);
            },
            child: Container(
                width: 320.w,
                height: 80.h,
                alignment: Alignment.center,
                color: Colors.green,
                child: Text(
                  "加入购物车",
                  style: TextStyle(color: Colors.white, fontSize: 28.sp),
                )),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: 320.w,
                height: 80.h,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  "立即购买",
                  style: TextStyle(color: Colors.white, fontSize: 28.sp),
                )),
          ),
        ],
      ),
    );
  }
}
