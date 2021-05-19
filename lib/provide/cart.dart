import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {

  String cartString = "[]";

  save( goodsId, goodsName, count, price, images)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int ival = 0;
    tempList.forEach((element) {
      if(element["goodsId"] == goodsId){
        tempList[ival]["count"] = element["count"] + 1;
        isHave = true;
      }
      ival++;
    });
    if(!isHave){
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true //是否已经选择
      });
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString("cartInfo", cartString);

    print("加入购物车完成");

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("cartInfo");

    print("清空购物车完成。、。、。。。。。");

    notifyListeners();

  }



}