import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwg/routers/routers.dart';

class Application{
  static FluroRouter router;
}


class RouterService{

  static void enterDetail(BuildContext context, String goodsId){
    Application.router.navigateTo(
        context,
        "${Routes.detailPagePath}?id=$goodsId",
        transition: TransitionType.native
    );
  }

}