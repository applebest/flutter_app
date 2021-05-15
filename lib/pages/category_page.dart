
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwg/service/service_method.dart';
import "dart:convert";
import 'package:flutterwg/models/categoay.dart';
import 'package:flutterwg/models/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwg/provide/child_category.dart';
import 'package:provider/provider.dart';



class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: [
            LeftCategoryNav(),

            Column(
              children: [
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )

          ],
        )
      ),

    );
  }
}


// todo 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {

  List<Data> list = [];

  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }


  void _getCategory() async {
    await request("getCategory").then((value) {
      var data =  json.decode(value.toString());
      CategoryModel  model = CategoryModel.fromJson(data);
      setState(() {
        list = model.data;
      });
      context.read<ChildCategory>().getChildCategory(list[0].bxMallSubDto);
    });
  }



  Widget _leftInkWell(int index){

    bool isClick = false;
    isClick = (index == listIndex);
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        context.read<ChildCategory>().getChildCategory(childList);
      },
      child: Container(
        height: 100.h,
        padding: EdgeInsets.only(left: 10,top: 20),
        decoration: BoxDecoration(
          color: isClick ? Colors.black12: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: 28.sp),
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              right: BorderSide(
                  width: 1,
                  color: Colors.black12
              )
          )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder:(context ,index){
          return _leftInkWell(index);
        },
      ),

    );
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  Widget _rightInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){

      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 10.0, 10.0),
        child: Text(
            item.mallSubName,
          style: TextStyle(
            fontSize: 28.sp,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    List<BxMallSubDto> list = context.watch<ChildCategory>().childCategoryList;
    return Container(
      height: 80.h,
      width: ScreenUtil().screenWidth - 180.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12
          )
        )
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context,index){
          return _rightInkWell(list[index]);
        },
      ),
    );
  }
}

// todo 商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}


class _CategoryGoodsListState extends State<CategoryGoodsList> {


  List<CategoryListData> list = [];

  _getGoodsList() async {

    var data = {
      'categoryId': "4",
      'categorySubId': "",
      'page': 1
    };
     await request('getMallGoods', formData: data).then((val) {
       var data = json.decode(val.toString());
       CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
       setState(() {
         list = model.data;
       });
     });
  }

  Widget _goodsImage (index){
    return Container(
      width: 200.w,
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName (index){
    return Container(
      width: 370.w,
      padding: EdgeInsets.all(5),
      child: Text(
          list[index].goodsName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 28.sp),
      ),
    );


  }

  Widget _goodsPrice(index){
    return Container(
        width: 370.w,
        margin: EdgeInsets.only(top: 30),
        child: Row(
        children: [
          Text(
              "价格:￥${list[index].presentPrice}",
            style: TextStyle(
              color: Colors.pink,
              fontSize: 30.sp
            ),
          ),
//          SizedBox(width: 10,),
          Text(
              "价格:￥${list[index].oriPrice}",
            style: TextStyle(
                color: Colors.black26,
                fontSize: 20.sp,
              decoration: TextDecoration.lineThrough
            ),
          ),
        ],
      )
    );
  }

  Widget _listItemWidget(index){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12
            )
          )
        ),
        child: Row(
          children: [
            _goodsImage(index),
            Column(
              children: [
                _goodsName(index),
                _goodsPrice(index)
              ],
            )
          ],
        ),
      ),
    );
  }



    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      width: 570.w,
      height: 980.h,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return _listItemWidget(index);
        },
      ),
    );



  }
}




