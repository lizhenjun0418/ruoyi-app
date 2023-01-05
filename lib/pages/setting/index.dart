import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';
import 'package:ruoyi_app/utils/sputils.dart';

/// 应用设置页面
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void _logout() {
    GetStorage().remove("token");
    SPUtil().remove("token");
    Get.offAllNamed(AppRouterConstant.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("应用设置"),
        ),
        body: Container(
          color: const Color.fromARGB(255, 244, 243, 243),
          child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
            child: Column(children: [
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: const Icon(Icons.lock_clock_outlined),
                  title: const Text("修改密码"),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onTap: () {
                    Get.toNamed(AppRouterConstant.modifyPassword);
                  },
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListTile(
                  leading: const Icon(Icons.update_outlined),
                  title: const Text("检查更新"),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onTap: () {
                    EasyLoading.showToast("模块建设中...");
                  },
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                child: ListTile(
                  leading: const Icon(Icons.cleaning_services_outlined),
                  title: const Text("清理缓存"),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onTap: () {
                    EasyLoading.showToast("模块建设中...");
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                width: 405,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: TextButton(
                  child: const Text(
                    "退出登录",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    _logout();
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
