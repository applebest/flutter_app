
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/counter.dart';


class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "${context.watch<Counter>().value}"
        ),
      ),

    );
  }
}
