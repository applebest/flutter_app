import 'package:flutter/material.dart';
import 'pages/Index_page.dart';


void main() {

  runApp(MyApp());
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

    return Container(
      child: MaterialApp(
        title: "百姓生活家",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),

    );
  }
}

