import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwg/models/cartInfo.dart';
import 'cart_count.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/cart.dart';


class CartItem extends StatelessWidget {

  final CartInfoModel item;

  const CartItem({Key key, this.item}) : super(key: key);




  // 多选按钮
  Widget _cartCheckBtn(BuildContext context){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool isSelected){
          item.isCheck = isSelected;
          Provider.of<CartProvider>(context,listen: false).changeCheckState(item);
        },
      ),
    );
  }

  // 图片
  Widget _cartImage(){
    return Container(
      width: 150.w,
      height: 150.h,
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }

  // 商品名称
  Widget _cartGoodsName(){
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Text(item.goodsName,),
          CartCount(),
        ],
      ),
    );
  }

  Widget _cartPrice(BuildContext context){

    return Container(
      width: 150.w,
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text("￥${item.price}"),
          Container(
            child: InkWell(
              onTap: (){
                Provider.of<CartProvider>(context,listen: false).deleteOneGoods(item.goodsId);
              },
              child: Icon(Icons.delete_forever,color: Colors.black26,size: 30,),

            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    print(item);

    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: Row(
        children: [

          _cartCheckBtn(context),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context)
        ],
      ),


    );
  }
}
