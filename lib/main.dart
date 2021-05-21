import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'pages/Index_page.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/counter.dart';
import 'provide/child_category.dart';
import 'provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import 'package:flutterwg/routers/routers.dart';
import 'package:flutterwg/routers/application.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'provide/cart.dart';
import 'provide/current_index.dart';

void main() {



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ChildCategory()), //大类数据传参
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvide() ), //商品分类数据交互
        ChangeNotifierProvider(create: (_) => DetailsInfoProvide() ), //详情交互
        ChangeNotifierProvider(create: (_) => CartProvider() ), //购物车交互
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider() ), //改变tabBar下标
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    return ScreenUtilInit(
//      designSize: Size(360, 690),
//      builder: () => MaterialApp(
//        debugShowCheckedModeBanner: false,
//        title: '百姓生活家',
//        theme: ThemeData(
//          primarySwatch: Colors.pink,
//        ),
//        builder: (context, widget) {
//          return MediaQuery(
//            //Setting font does not change with system font size
//            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
//            child: widget,
//          );
//        },
//        home: IndexPage(),
//      ),
//    );
//
    final router  = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: "百姓生活家",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        onGenerateRoute: Application.router.generator,
        home: IndexPage(),
      ),

    );
  }
}

