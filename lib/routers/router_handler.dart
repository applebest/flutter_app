import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwg/pages/detail_page.dart';


  Handler detailsHander = Handler(
      handlerFunc:(BuildContext context, Map<String, List<String>> parameters){
          String goodsId = parameters["id"].first;
          print("index>details>goodsId$goodsId");
          return DetailsPage(goodsId: goodsId);
      },



  );
