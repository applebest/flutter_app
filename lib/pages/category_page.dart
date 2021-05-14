
import 'package:flutter/material.dart';
import 'package:flutterwg/service/service_method.dart';
import "dart:convert";

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  void _getCategory() async {

    await request("getCategory").then((value) {
      var data =  json.decode(value.toString());
      print( "类别===========> ${value}" );
    });

  }



  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Scaffold(
      body: Center(
        child: Text(
            "分类页面"
        ),
      ),

    );
  }
}
