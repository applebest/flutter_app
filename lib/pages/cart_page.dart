import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class CartPage extends StatefulWidget {
//  @override
//  _CartPageState createState() => _CartPageState();
//}
//
//class _CartPageState extends State<CartPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Text(
//            "购物车页面"
//        ),
//      ),
//
//    );
//  }
//}

class CartPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CartPage> {
  List<String> testList = [];

  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = "的首付多少老会计风口浪尖";
    testList.add(temp);

    prefs.setStringList("testInfo", testList);
    _show();
  }

  // 查询
  _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("testInfo") != null) {
      setState(() {
        testList = prefs.getStringList("testInfo");
      });
    }
  }

  _remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("testInfo");
    setState(() {
      testList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 500,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
              itemCount: testList.length,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _add();
            },
            child: Text("增加"),
          ),
          ElevatedButton(
            onPressed: () {
              _remove();
            },
            child: Text("清空"),
          ),
        ],
      ),
    );
  }
}
