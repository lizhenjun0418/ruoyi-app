import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/pages/error/404.dart';
import 'package:ruoyi_app/pages/login/login.dart';
import 'package:ruoyi_app/pages/page_index.dart';
import 'package:ruoyi_app/pages/persion/persional_page.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';

/// 路由
class AppRouterPage {
  static final routers = [
    GetPage(name: AppRouterConstant.Home, page: () => const PageIndex()),
    GetPage(name: AppRouterConstant.Login, page: () => const LoginPage()),
    GetPage(name: AppRouterConstant.Error_404, page: () => const ErrorPage()),
    GetPage(
        name: AppRouterConstant.Persional, page: () => const PersionalPage())
  ];

  /// 路由
  static final Map<String, WidgetBuilder> routerMaps = {
    AppRouterConstant.Home: (context) => const PageIndex(),
    AppRouterConstant.Login: (context) => const LoginPage(),
    AppRouterConstant.Error_404: (context) => const ErrorPage(),
    AppRouterConstant.Persional: (context) => const PersionalPage()
  };

  ///路由拦截
  static Route onGenerateRoute(RouteSettings settings) {
    final String? name = settings.name;
    var pageContentBuilder = routerMaps[name];

    /// 如果路由表中未定义，跳转到未定义路由页面
    pageContentBuilder ??= (context) => const ErrorPage();

    if (!GetStorage().hasData("token")) {
      pageContentBuilder = (context) => const LoginPage();
    }

    // 构建动态的route
    final route = MaterialPageRoute(
      builder: pageContentBuilder,
      settings: settings,
    );
    return route;
  }
}
