import 'package:flutter/material.dart';
import 'package:flutterwg/models/details.dart';
import 'package:flutterwg/service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {

  DetailsModel goodsInfo;

  bool isLeft = true;
  bool isRight = false;


  changeLeftAndRight(String changeState){
    if(changeState == "left"){
      isLeft = true;
      isRight = false;
    }else{
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }


  // 从后台获取商品数据
  getGoodsInfo(String goodsId) async {

    var fromData = {"goodId":goodsId};
    await request("getGoodDetailById",formData:fromData).then((value){
      var responseData = json.decode(value.toString());
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });


  }


}



