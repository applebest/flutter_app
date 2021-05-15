
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/counter.dart';

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

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          children: [
            Number(),
            Mybutton(),
          ],
        ),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 200),
//      margin: EdgeInsets.only(top: 200),

      child:

//      Consumer<Counter>(
//        builder: (context, notifier, child) {
//          return Text("${notifier.value}");
//        },
//      )

      Text(
//        "${Provider.of<Counter>(context).value}"
          "${context.watch<Counter>().value}"  // 等价
      ),

    );
  }
}

class Mybutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      margin: EdgeInsets.only(top: 50),
      child: ElevatedButton(
        onPressed:(){
//          Provider.of<Counter>(context,listen: false).increment();
          context.read<Counter>().increment();  // 等价
        },
        child: Text(
            "递增+"
        ),
      ),
    );
  }
}


