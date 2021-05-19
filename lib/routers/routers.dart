import 'dart:ffi';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterwg/routers/router_handler.dart';

class Routes {
  static String root = "/";
  static String detailPagePath = "/detail";
  static void configureRoutes(FluroRouter router) {

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print("ROUTE WAS NOT FOUND !!!");
          return;
        });

    // detail路由
    router.define(detailPagePath, handler: detailsHander);



  }

}