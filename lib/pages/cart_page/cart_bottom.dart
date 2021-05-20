import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwg/provide/cart.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  Widget _selectAllBtn(BuildContext context) {

    bool isAllCheck  = Provider.of<CartProvider>(context,listen: false).isAllCheck;

    return Container(
        child: Row(
      children: [
        Checkbox(
          value: isAllCheck,
          onChanged: (bool isSelected) {
            Provider.of<CartProvider>(context,listen: false).changeAllCheckBtnState(isSelected);
          },
          activeColor: Colors.pink,
        ),
        Text("全选"),
      ],
    ));
  }

  Widget _allPriceArea(BuildContext context) {
    double allPrice =
        Provider.of<CartProvider>(context, listen: false).allPrice;

    return Container(
      width: 430.w,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  "合计:",
                  style: TextStyle(fontSize: 36.sp),
                ),
                alignment: Alignment.centerRight,
                width: 280.w,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 150.w,
                child: Text(
                  "￥$allPrice",
                  style: TextStyle(fontSize: 36.sp, color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: 430.w,
            alignment: Alignment.centerRight,
            child: Text(
              "满10元免配送费，预购免配送费",
              style: TextStyle(color: Colors.black38, fontSize: 22.sp),
            ),
          )
        ],
      ),
    );
  }

  Widget _goButton(BuildContext context) {
    int count = Provider.of<CartProvider>(context, listen: false).allGoodsCount;

    return Container(
      width: 160.w,
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            "结算($count)",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Consumer<CartProvider>(
          builder: (context, value, child) {
            return Row(
              children: [
                _selectAllBtn(context),
                _allPriceArea(context),
                _goButton(context),
              ],
            );
          },
        ));
  }
}
