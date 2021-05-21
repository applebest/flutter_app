import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwg/models/cartInfo.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/cart.dart';

class CartCount extends StatelessWidget {

  final  CartInfoModel model;

  CartCount(this.model);

  // 减少按钮
  Widget _reduceBtn(BuildContext context){

    return InkWell(
      onTap: (){
        Provider.of<CartProvider>(context,listen: false).addOrReduceAction(model, "reduce");
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: model.count > 1 ? Colors.white : Colors.black12,
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child:model.count > 1? Text("-") : Text(" ")
      ),
    );
  }


  // 加号按钮
  Widget _addBtn(BuildContext context){

    return InkWell(
      onTap: (){
        Provider.of<CartProvider>(context,listen: false).addOrReduceAction(model, "add");
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:Colors.white,
            border: Border(
                left: BorderSide(width: 1,color: Colors.black12)
            )
        ),
        child:Text("+"),
      ),
    );
  }

  // 中间数量显示区域
  Widget _centerNumber(BuildContext context){

    return Container(
      width: 70.w,
      height:45.h,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("${model.count}"),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),

      child: Row(
        children: [
          _reduceBtn(context),
          _centerNumber(context),
          _addBtn(context),

        ],
      ),
    );
  }
}

