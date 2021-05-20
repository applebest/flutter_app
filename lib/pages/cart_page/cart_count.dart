import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatelessWidget {

  // 减少按钮
  Widget _reduceBtn(){

    return InkWell(
      onTap: (){},
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text("-"),
      ),
    );
  }


  // 加号按钮
  Widget _addBtn(){

    return InkWell(
      onTap: (){},
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(width: 1,color: Colors.black12)
            )
        ),
        child: Text("+"),
      ),
    );
  }

  // 中间数量显示区域
  Widget _centerNumber(){

    return Container(
      width: 70.w,
      height:45.h,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("1"),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.black12)
      ),

      child: Row(
        children: [
          _reduceBtn(),
          _centerNumber(),
          _addBtn(),

        ],
      ),
    );
  }
}

