import 'package:ruoyi_app/enmus/http_method.dart';
import 'package:ruoyi_app/utils/request.dart';

/// 获取路由
var getRouters = () async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/getRouters", true, method: DioMethod.get);
};
