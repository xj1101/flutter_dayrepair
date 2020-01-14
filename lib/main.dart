import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:amap_location/amap_location.dart';

import 'routes/Route.dart'; //路由
import 'provider/Mall_provider.dart';
import 'provider/User_provider.dart';

import 'services/i18n.dart';

void main() {
  AMapLocationClient.setApiKey("a8a758844cedda920a28b58625bb8362");
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MallTJProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: Colors.white,
          splashColor: Colors.white, //去掉点击水波纹颜色
          textTheme: TextTheme(
            subhead: TextStyle(
              textBaseline: TextBaseline.alphabetic //设置光标对齐
            )
          )
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalEasyRefreshLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}