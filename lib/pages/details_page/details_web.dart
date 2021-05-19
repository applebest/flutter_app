import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String goodsDetails = Provider.of<DetailsInfoProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;

    print(goodsDetails);
    return Consumer<DetailsInfoProvide>(builder: (context, value, child) {
      bool isLeft =
          Provider.of<DetailsInfoProvide>(context, listen: false).isLeft;

      if (isLeft) {
        return Container(
          child: Html(
            data: goodsDetails,
          ),
        );
      } else {
        return Container(
          width: 750.w,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text("暂无数据"),
        );
      }
    });
  }
}
