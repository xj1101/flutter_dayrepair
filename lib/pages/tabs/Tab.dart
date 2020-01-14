import 'package:dayrepair/services/XJExtension.dart';
import 'package:flutter/material.dart';

import 'Home.dart'; //首页
// import 'Mall.dart'; //商城
import 'Join.dart'; //加盟
import 'My.dart'; //我的
import 'NewsMall.dart';
import '../../pages/login/Login.dart';


class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex = 0; //记录当前选中的下标
  PageController _pageController; //控制器

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: this._currentIndex);
  }

  //控制器数组
  List<Widget> _pageList = [
    HomePage(),
    MallPage(),
    JoinPage(),
    MyPage(),
    // LoginPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        onPageChanged: (index){
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止上下滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: XJColors.hexColor(0x2a62e8),
        onTap: (index){
          this._currentIndex = index;
          this._pageController.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              this._currentIndex==0?AssetImage("images/home_select_tab.png"):AssetImage("images/home_tab.png"),
            ),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              this._currentIndex==1?AssetImage("images/mall_select_tab.png"):AssetImage("images/mall_tab.png"),
            ),
            title: Text('商城')
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              this._currentIndex==2?AssetImage("images/join_select_tab.png"):AssetImage("images/join_tab.png"),
            ),
            title: Text('加盟')
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              this._currentIndex==3?AssetImage("images/my_select_tab.png"):AssetImage("images/my_tab.png"),
            ),
            title: Text('我的')
          )
        ],
      ),
    );
  }
}