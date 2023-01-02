import 'package:flutter/material.dart';
import '../pages/login/login.dart';
import '../pages/page_index.dart';
import 'app_router_constant.dart';

/// 路由
final Map<String, Function> routers = {
  AppRouterConstant.Home: (context) => const PageIndex(),
  AppRouterConstant.Login: (context) => const LoginPage()
};

///路由拦截
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
