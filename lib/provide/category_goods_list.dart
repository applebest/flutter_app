
import 'package:flutter/material.dart';
import 'package:flutterwg/models/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> _goodsList = [];

  List<CategoryListData> get goodsList  => _goodsList;

  // 点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list){
    if(list == null){
      _goodsList = [];
    }else{
      _goodsList = list;
    }
    notifyListeners();
  }

  getMoreList(List<CategoryListData> list){

    _goodsList.addAll(list);
    notifyListeners();
  }


}