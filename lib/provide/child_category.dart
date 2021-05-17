
import 'package:flutter/material.dart';
import 'package:flutterwg/models/categoay.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> _childCategoryList = [];
  List<BxMallSubDto> get childCategoryList  => _childCategoryList;

  int _childIndex = 0;  // 子类高亮索引
  int get childIndex  => _childIndex;  // 子类高亮索引

  String _categoryId = "4"; // 大类id默认为4
  String get categoryId  => _categoryId;  //大类id默认为4

  String _subId = "";
  String get subId => _subId;


  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list ,String categoryId){
    _childIndex = 0;
    _categoryId = categoryId;
    BxMallSubDto all =  BxMallSubDto();
    all.mallSubId = "";
    all.mallCategoryId = "123";
    all.comments ="1244";
    all.mallSubName = "全部";
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    notifyListeners();
  }

  // 子类切换逻辑
  changeChildIndex(index,String id){
    _childIndex = index;
    _subId = id;
    notifyListeners();
  }




}