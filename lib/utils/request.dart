import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';
import 'package:ruoyi_app/utils/sputils.dart';
import '../enmus/http_method.dart';
import 'package:dio/src/response.dart' as doi_respones;

class DioRequest {
  /// 单例模式
  static DioRequest? _instance;
  factory DioRequest() => _instance ?? DioRequest._internal();
  static DioRequest? get instance => _instance ?? DioRequest._internal();

  /// 连接超时时间
  static const int connectTimeout = 60 * 1000;

  /// 响应超时时间
  static const int receiveTimeout = 60 * 1000;

  /// 请求地址
  static const baseURL = "http://localhost:8080/";

  /// Dio实例
  static Dio _dio = Dio();

  static GetStorage getStorage = GetStorage();

  /// 初始化
  DioRequest._internal() {
    // 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: baseURL,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {});
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  /// 请求拦截器
  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 头部添加token
    // options.headers["token"] = "xxx";
    // 更多业务需求
    handler.next(options);
    // super.onRequest(options, handler);
  }

  /// 相应拦截器
  void _onResponse(doi_respones.Response response,
      ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    // if (response.statusCode == 200) {
    //   // ....
    // } else {
    //   // ....
    // }
    int code = response.data["code"];
    if (code == 403) {
      SPUtil().clean();
      GetStorage().erase();
      Get.toNamed(AppRouterConstant.login);
    }
    if (code == 401) {
      SPUtil().clean();
      GetStorage().erase();
      Get.offAll(AppRouterConstant.login);
    }
    handler.next(response);
  }

  /// 错误处理
  void _onError(DioError error, ErrorInterceptorHandler handler) {
    handler.next(error);
  }

  /// 请求类
  Future<T> request<T>(
    String path,
    bool isToken, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    if (isToken) {
      if (!getStorage.hasData("token")) {
        var token = SPUtil().get("token");
        if (token != null && token != "") {
          getStorage.write("token", token);
        } else {
          // 没有token，跳抓登录页面
          getStorage.remove("token");
          SPUtil().remove("token");
          Get.offNamed(AppRouterConstant.login);
        }
      }
      print("token: ${getStorage.read("token")}");
      options ??= Options(method: methodValues[method], headers: {
        "content-type": "application/json; charset=utf-8",
        "Authorization": "Bearer ${getStorage.read("token")}"
      });
    } else {
      options ??= Options(
          method: methodValues[method],
          headers: {"content-type": "application/json; charset=utf-8"});
    }
    try {
      doi_respones.Response response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } on DioError {
      rethrow;
    }
  }

  /// 开启日志打印
  /// 需要打印日志的接口在接口请求前 DioUtil.instance?.openLog();
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}
