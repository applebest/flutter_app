
import 'package:flutter/material.dart';
import 'package:flutterwg/models/categoay.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> _childCategoryList = [];

  List<BxMallSubDto> get childCategoryList  => _childCategoryList;

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all =  BxMallSubDto();
    all.mallSubId = "00";
    all.mallCategoryId = "123";
    all.comments ="1244";
    all.mallSubName = "全部";
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    notifyListeners();
  }

}