
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterwg/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// 保持页面 AutomaticKeepAliveClientMixin
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  // 重写
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body:FutureBuilder(
        future: getHomePageContent(),
        builder: (context,snapshot){
            if(snapshot.hasData){
              var data  = json.decode(snapshot.data.toString());

              //todo 轮播
              List<Map> swiper = (data["data"]["slides"] as List).cast(); // 轮播图
              // todo 类别列表
              List<Map> navigatorList = (data['data']['category'] as List).cast(); //类别列表
              // todo 广告图片 拨打电话
              String  adPicture = data["data"]["advertesPicture"]["PICTURE_ADDRESS"]; // 广告图片
              String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
              String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
              // todo 推荐部分
              List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐



              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiper,), // 轮播图小部件
                    TopNavigator(navigatorList: navigatorList), //导航小部件
                    AdBanner(adPicture: adPicture,), // 广告部件
                    LeaderPhone(leaderImage: leaderImage,leaderPhone: leaderPhone), //打电话小部件
                    Recommend(recommendList: recommendList),
                  ],
                )
              );
            }else{
              return Center(
                child: Text("加载中...."),
              );
            }
        },
      )

    );

  }
  
}


// todo 首页轮播组件
class SwiperDiy extends StatelessWidget {

  final List swiperDateList;

  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.h,
      width: 750.w,
      child: Swiper(
        itemBuilder: (context ,index){
          return Image.network("${swiperDateList[index]["image"]}",fit: BoxFit.fill,);
        },
        itemCount: swiperDateList.length,
        pagination:SwiperPagination() ,
        autoplay: true,
      ),
    );
  }
}


// todo 头部小部件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context , item){
    return InkWell(
      onTap: (){print("点击了导航");},
      child: Column(
        children: [
          Image.network(item["image"],width: 95.w,),
          Text(item["mallCategoryName"]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: 240.h,
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
//        physics: NeverScrollableScrollPhysics(),   // 设置不可滑动
        crossAxisCount:5,
          padding: EdgeInsets.all(5.0),
        children:navigatorList.map((e) {
          return _gridViewItemUI(context, e);
        }).toList(),
      ),
    );
  }
}

//todo 广告图片
class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner({Key key, this.adPicture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}


//todo 店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长图片
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key); // 店长电话

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          print("点击");
          print(leaderPhone);
//          String phone = "tel:"+leaderPhone;
          String phone =  "https://www.baidu.com/";
          await canLaunch(phone) ? await launch(phone) :throw '不能拨打 $phone';
        },
        child: Image.network(leaderImage),
      ),
    );
  }
}

//todo 商品推荐模块
class Recommend extends StatelessWidget {
  final List recommendList;

  const Recommend({Key key, this.recommendList}) : super(key: key);

  //标题 小部件
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),

    );
  }

  //图片 小部件
  Widget _item(index){

    return InkWell(
      onTap: (){},
      child: Container(
        width: 290.w,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Column(
          children: [
            Image.network(recommendList[index]["image"]),
            Text("￥${recommendList[index]["mallPrice"]}"),
            Text("￥${recommendList[index]["price"]}",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )

          ],
        ),
      ),
    );

  }

  //横向列表小部件
  Widget _recommedList(){
    return Container(
      height: 300.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10.0),
      child: Column(
        children: [
          _titleWidget(),
          _recommedList()
        ],
      ),
    );
  }
}




