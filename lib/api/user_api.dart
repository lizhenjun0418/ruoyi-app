import '../enmus/http_method.dart';
import '../utils/request.dart';

/// 获取用户信息
var getUserProfile = () async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance
      ?.request("/system/user/profile", true, method: DioMethod.get);
};

/// 修改密码
var updatePassword = (dataForm) async {
  DioRequest.instance?.openLog();
  return await DioRequest.instance?.request(
      "/system/user/profile/updatePwd", true,
      method: DioMethod.put, params: dataForm);
};

/// 更新用户信息
var updateProfile = (data) async {
  DioRequest.instance?.openLog();
  return await DioRequest()
      .request("/system/user/profile", true, method: DioMethod.put, data: data);
};
