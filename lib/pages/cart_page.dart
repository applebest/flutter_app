import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/cart.dart';
import 'package:flutterwg/models/cartInfo.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return "end";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CartInfoModel> cartList =
                Provider.of<CartProvider>(context, listen: false).cartList;
            return Stack(
              children: [
                Consumer<CartProvider>(builder: (context, value, child) {

                  cartList = Provider.of<CartProvider>(context,listen: false).cartList;

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItem(
                        item: cartList[index],
                      );
                    },
                    itemCount: cartList.length,
                  );
                }),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child:   CartBottom(),
                ),
              ],
            );

            return ListView.builder(
              itemBuilder: (context, index) {
                return CartItem(
                  item: cartList[index],
                );
              },
              itemCount: cartList.length,
            );
          } else {
            return Text("正在加载");
          }
        },
      ),
    );
  }
}
