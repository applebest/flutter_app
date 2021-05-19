import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  // 商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: 740.w,
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: 740.w,
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 30.sp,
        ),
      ),
    );
  }

  Widget _goodsNumebr(num) {
    return Container(
      width: 730.w,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        "编号:$num",
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: 730.w,
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Text(
            '￥$presentPrice',
            style: TextStyle(color: Colors.pinkAccent, fontSize: 40.sp),
          ),

//          SizedBox(width: 20,),

//          Text(
//            '市场价:￥$oriPrice',
//            style: TextStyle(
//                color: Colors.black26,
//                decoration: TextDecoration.lineThrough
//            ),
//          ),

          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              '市场价:￥$oriPrice',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsInfoProvide>(
        builder: (BuildContext context, value, child) {
      var goodsInfo = Provider.of<DetailsInfoProvide>(context, listen: false)
          .goodsInfo
          .data
          .goodInfo;
      print(goodsInfo);
      if (goodsInfo != null) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(2),
          child: Column(
            children: [
              _goodsImage(goodsInfo.image1),
              _goodsName(goodsInfo.goodsName),
              _goodsNumebr(goodsInfo.goodsSerialNumber),
              _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
            ],
          ),
        );
      } else {
        return Center(
          child: Text("加载中...."),
        );
      }
    });
  }
}
