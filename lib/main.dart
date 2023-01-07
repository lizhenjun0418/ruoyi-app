import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/pages/page_index.dart';
import 'package:ruoyi_app/router/app_router.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /// 初始化路由
  void _initRouter() {
    GetStorage getStorage = GetStorage();
    String routerKey = getStorage.hasData("token")
        ? AppRouterConstant.home
        : AppRouterConstant.login;
    getStorage.write("initialRouteKey", routerKey);
  }

  @override
  Widget build(BuildContext context) {
    _initRouter();
    return GetMaterialApp(
      title: '若依APP',
      theme: ThemeData(
          primaryColor: Colors.white, primarySwatch: Colors.lightBlue),
      home: const PageIndex(),
      debugShowCheckedModeBanner: false,
      initialRoute: GetStorage().read("initialRouteKey"),
      getPages: AppRouterPage.routers,
      onGenerateRoute: AppRouterPage.onGenerateRoute,
      builder: EasyLoading.init(),
      unknownRoute: AppRouterPage.errorPage,
    );
  }
}
