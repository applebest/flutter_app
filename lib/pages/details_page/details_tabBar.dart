
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsTabBar extends StatelessWidget {


  Widget _MyTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){
        Provider.of<DetailsInfoProvide>(context,listen: false).changeLeftAndRight("left");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isLeft?Colors.pink : Colors.black12
                )
            )
        ),
        child: Text(
          "详情",
          style: TextStyle(
              color: isLeft?Colors.pink : Colors.black
          ),
        ),


      ),

    );

  }


  Widget _MyTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){
        Provider.of<DetailsInfoProvide>(context,listen: false).changeLeftAndRight("right");
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isRight?Colors.pink : Colors.black12
                )
            )
        ),
        child: Text(
          "评论",
          style: TextStyle(
              color: isRight?Colors.pink : Colors.black
          ),
        ),


      ),

    );

  }



  @override
  Widget build(BuildContext context) {

    return Consumer<DetailsInfoProvide>(
        builder:(context,value,child){

          bool isLeft = Provider.of<DetailsInfoProvide>(context,listen: false).isLeft;
          bool isRight = Provider.of<DetailsInfoProvide>(context,listen: false).isRight;

          return Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                _MyTabBarLeft(context, isLeft),
                _MyTabBarRight(context, isRight),
              ],
            ),

          );

        }
    );
  }
}
