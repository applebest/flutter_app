import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterwg/provide/details_info.dart';
import 'details_page/details_top_area.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_tabBar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  const DetailsPage({Key key, this.goodsId}) : super(key: key);

  Future _getBackInfo(BuildContext context) async {
    await Provider.of<DetailsInfoProvide>(context, listen: false)
        .getGoodsInfo(goodsId);
    print("加载完成");

    return "完成加载";
  }

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Container(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            title: Text("商品详情"),
          ),
          body: FutureBuilder(
            future: _getBackInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        child: ListView(
                          children: [
                            DetailsTopArea(),
                            DetailsExplain(),
                            DetailsTabBar(),
                            DetailsWeb()
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: DetailsBottom(),
                      ),
                    ],
                  ),
                );
              } else {
                return Text("加载中...");
              }
            },
          )),
    );
  }
}
