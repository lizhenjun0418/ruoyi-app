import '../enmus/http_method.dart';
import '../utils/request.dart';

/// 获取用户信息
var getUserProfile = () async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/system/user/profile", true, method: DioMethod.get);
};
