
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwg/service/service_method.dart';
import "dart:convert";
import 'package:flutterwg/models/categoay.dart';
import 'package:flutterwg/models/categoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwg/provide/child_category.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
    _getGoodsList();
  }


  void _getCategory() async {
    await request("getCategory").then((value) {
      var data =  json.decode(value.toString());
      CategoryModel  model = CategoryModel.fromJson(data);
      setState(() {
        list = model.data;
      });
      context.read<ChildCategory>().getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }

  _getGoodsList({String categoryId}) async {

    var data = {
      'categoryId': categoryId ?? "4",
      'categorySubId': "",
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      if(model != null){
        context.read<CategoryGoodsListProvide>().getGoodsList(
            model.data
        );
      }else{
        context.read<CategoryGoodsListProvide>().getGoodsList(null);
      }

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
        var categoryId = list[index].mallCategoryId;
        context.read<ChildCategory>().getChildCategory(childList,categoryId);
        _getGoodsList(categoryId: categoryId);
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
          return  _leftInkWell(index);
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



  _getGoodsList(String categorySubId) async {

    var data = {
      'categoryId':  Provider.of<ChildCategory>(context,listen: false).categoryId,
      'categorySubId':categorySubId,
      'page': 1
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      print(data);
      if(model != null){
        Provider.of<CategoryGoodsListProvide>(context,listen: false).getGoodsList(
            model.data
        );

      }else{
        Provider.of<CategoryGoodsListProvide>(context,listen: false).getGoodsList(
           null
        );
      }

    });
  }




  Widget _rightInkWell(int index, BxMallSubDto item){

    bool isClick = (index ==  Provider.of<ChildCategory>(context, listen: false).childIndex);

    return InkWell(
      onTap: (){
        Provider.of<ChildCategory>(context, listen: false).changeChildIndex(index,item.mallSubId);
          _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 10.0, 10.0),
        child: Text(
            item.mallSubName,
          style: TextStyle(
            fontSize: 28.sp,
            color: isClick ? Colors.pink : Colors.black
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
      child:  ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context,index){
          return _rightInkWell(index, list[index]);
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

  EasyRefreshController _controller = EasyRefreshController();

  ScrollController    _scrollController = ScrollController();

  Widget _goodsImage (List<CategoryListData>list,index){
    return Container(
      width: 200.w,
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName (List<CategoryListData>list,index){
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

  Widget _goodsPrice(List<CategoryListData>list,index){
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

  Widget _listItemWidget(List<CategoryListData>list, index){
    return InkWell(
      onTap: (){

      },
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
            _goodsImage(list, index),
            Column(
              children: [
                _goodsName(list, index),
                _goodsPrice(list, index)
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
  }



  Future _onLoad() async{

    _getMoreList();

  }

  Future _onRefresh() async {
    print("下拉刷新");

  }


  _getMoreList() async {

    Provider.of<ChildCategory>(context,listen: false).addPage();
    var data = {
      'categoryId': Provider.of<ChildCategory>(context,listen: false).categoryId,
      'categorySubId': Provider.of<ChildCategory>(context,listen: false).subId,
      'page': Provider.of<ChildCategory>(context,listen: false).page
    };
    await request('getMallGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel model = CategoryGoodsListModel.fromJson(data);
      print("打印model 。。。|${model}");
      if(model != null && model.data != null && model.data.length > 0){
        Provider.of<CategoryGoodsListProvide>(context,listen: false).getMoreList(model.data);
      }else{

        print("到底了============================");
        Provider.of<ChildCategory>(context,listen: false).changeNoreText("没有更多了");

        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT, // 提示的长短
          gravity:ToastGravity.CENTER ,    // 提示的位置
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 16 ,
        );

      }

    });
  }


  @override
  Widget build(BuildContext context) {
  return  Consumer<CategoryGoodsListProvide>(
    builder:(context,data,child){

      try{

        int page =  Provider.of<ChildCategory>(context,listen: false).page;
        if(page == 1){
           // 列表放到最上面
          _scrollController.jumpTo(0.0);
        }


      }catch(e){
        print("进入页面第一次初始化${e}");
      }

      bool isEmpty  = data.goodsList.length == 0 ;

      print("重新绘制----");
      return Expanded(
          child:  Container(
            width: 570.w,
//            height: 980.h,
            child: isEmpty ? Center(child: Text("暂无数据"),) :
              EasyRefresh(
                  footer: ClassicalFooter(

                    showInfo: false,
                    bgColor: Colors.white,
                    //  更多信息文字颜色
                    infoColor: Colors.pink,
                    // 字体颜色
                    textColor: Colors.pink,
                    loadingText:"加载中...",
                    // 没有更多时显示的文字  Provider.of<ChildCategory>(context,listen: false).noMoreText
                    noMoreText: Provider.of<ChildCategory>(context,listen: false).noMoreText,
                    // 正在加载时的文字
                    loadedText:"加载完成",
                    // 准备加载时显示的文字
                    loadReadyText:"上拉加载....",
                  ),
//                  controller: _controller,
//                  enableControlFinishRefresh: true,
//                  enableControlFinishLoad: true,
                  onLoad:_onLoad,
                  onRefresh:_onRefresh,
                  child:ListView.builder(
                    controller: _scrollController,
                    itemCount: data.goodsList.length,
                    itemBuilder: (context,index){
                      return _listItemWidget(data.goodsList, index);
                    },
                  )
              )
          )

      );
    },
  );


  }
}




