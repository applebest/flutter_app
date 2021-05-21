import 'package:flutter/material.dart';
import 'package:flutterwg/pages/cart_page/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutterwg/models/cartInfo.dart';

class CartProvider with ChangeNotifier {

  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double allPrice = 0;  // 总价格
  int allGoodsCount = 0; // 商品总数量
  bool isAllCheck = true; // 是否全选

  save( goodsId, goodsName, count, price, images)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int ival = 0;
    allPrice = 0.0;
    allGoodsCount = 0;
    tempList.forEach((element) {
      if(element["goodsId"] == goodsId){
        tempList[ival]["count"] = element["count"] + 1;
        cartList[ival].count ++;
        isHave = true;
      }
      if(element["isCheck"]){
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount +=  cartList[ival].count;
      }
      
      ival++;
    });
    if(!isHave){

      Map<String,dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
      allPrice += (price * count);
      allGoodsCount += count;

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
    cartList = [];
    print("清空购物车完成。、。、。。。。。");

    notifyListeners();

  }

  getCartInfo () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    if(cartString == null){
      cartList = [];
    }else{
       List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
       allPrice = 0;
       allGoodsCount = 0;
       isAllCheck = true;
       tempList.forEach((element) {
         if(element["isCheck"]){

           allPrice +=  element["price"] * element["count"];
           allGoodsCount  += element["count"];
         }else{
            isAllCheck = false;

         }
         
         cartList.add(CartInfoModel.fromJson(element));
       });
    }
    notifyListeners();
  }


  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async {

    print("删除");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    int index = 0;
    List<Map> tempList = (temp as List).cast();
     for (int i = 0; i < tempList.length; i++){
         var item = tempList[i];
         if(item["goodsId"] == goodsId){
           index  = i;
           break;
         }
     }

     tempList.removeAt(index);

     cartString = json.encode(tempList).toString();
     prefs.setString(cartString, "cartInfo");

     await getCartInfo();

  }


  changeCheckState(CartInfoModel model) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    int index = 0;
    List<Map> tempList = (temp as List).cast();
    for (int i = 0; i < tempList.length; i++){
      var item = tempList[i];
      if(item["goodsId"] == model.goodsId){
        index  = i;
        break;
      }
    }

    tempList[index] = model.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString(cartString, "cartInfo");
    await getCartInfo();
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    List<Map> tempList = (temp as List).cast();
    List<Map> newList = [];
    for (var item in tempList){
      var newItem = item;
      newItem["isCheck"] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    prefs.setString(cartString, "cartInfo");
    await getCartInfo();

  }

  Future<List<Map>> _getListData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString("cartInfo");
    var temp =  cartString == null ? [] : json.decode(cartString.toString()) ;
    List<Map> tempList = (temp as List).cast();
    return tempList;
  }


  // 商品数量加减
  addOrReduceAction(CartInfoModel model ,String todo) async {

    List<Map> tempList = await _getListData();
    
    int index = 0;
    for (int i = 0; i < tempList.length; i++){
      var item = tempList[i];
      if(item["goodsId"] == model.goodsId){
        index  = i;
        break;
      }
    }

    if(todo == "add"){

      model.count ++;

    }else if(model.count > 1){
      model.count --;
    }

    tempList[index] = model.toJson();
    cartString = json.encode(tempList).toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cartString, "cartInfo");
    await getCartInfo();

  }





}