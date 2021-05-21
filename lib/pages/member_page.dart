import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            height: 200.h,
            child: ClipOval(
              child: Image.network(
                  "https://img0.baidu.com/it/u=3391932263,1207799126&fm=26&fmt=auto&gp=0.jpg"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "妹妹",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 36.sp,
              ),
            ),
          )
        ],
      ),
    );
  }


  // 我的订单
  Widget _orderTitle(){

    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("我的订单"),
        trailing: Icon(Icons.arrow_right),


      ),
    );
  }

  Widget _orderType(){

    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().screenWidth,
      height: 150.h,
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: ScreenUtil().screenWidth / 4,
            child: Column(
              children: [
                Icon(Icons.party_mode,size: 30,),
                Text("待付款")
              ],
            ),
          ),
          Container(
            width: ScreenUtil().screenWidth / 4,
            child: Column(
              children: [
                Icon(Icons.query_builder,size: 30,),
                Text("待发货")
              ],
            ),
          ),

          Container(
            width: ScreenUtil().screenWidth / 4,
            child: Column(
              children: [
                Icon(Icons.directions_car,size: 30,),
                Text("待收货")
              ],
            ),
          ),

          Container(
            width: ScreenUtil().screenWidth / 4,
            child: Column(
              children: [
                Icon(Icons.edit,size: 30,),
                Text("待评价")
              ],
            ),
          ),


        ],
      ),
    );
  }

  // 通用listTitle
  Widget _myListTitle(String title){

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.block),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),

    );

  }


  Widget _listTileList(){

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _myListTitle("领取优惠券"),
          _myListTitle("已领取优惠券"),
          _myListTitle("地址管理"),
          _myListTitle("客服电话"),
          _myListTitle("关于我们"),
        ],
      ),

    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("会员中心"),
      ),
      body: ListView(
        children: [
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _listTileList(),
        ],
      ),
    );
  }
}


