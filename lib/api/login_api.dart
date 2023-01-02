import 'package:ruoyi_app/enmus/http_method.dart';
import '../utils/request.dart';

/// 获取图片验证码
var getImage = () async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/captchaImage", false, method: DioMethod.get);
};

/// 登录接口
var login = (loginForm) async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/login", false, data: loginForm, method: DioMethod.post);
};

/// 获取用户信息
var getInfo = () async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/getInfo", true, method: DioMethod.get);
};
