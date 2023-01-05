import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ruoyi_app/api/user_api.dart';

/// 修改密码
class ModifyPaswordPage extends StatefulWidget {
  const ModifyPaswordPage({Key? key}) : super(key: key);

  @override
  State<ModifyPaswordPage> createState() => _ModifyPaswordPageState();
}

class _ModifyPaswordPageState extends State<ModifyPaswordPage> {
  String oldPassword = "";
  String newPassword = "";
  String confirmPassword = "";

  void _submit() async {
    if (oldPassword == "") {
      EasyLoading.showToast("请输入原始密码");
      return;
    }
    if (newPassword == "") {
      EasyLoading.showToast("请输入密码");
      return;
    }
    if (confirmPassword == "") {
      EasyLoading.showToast("请输入确认密码");
      return;
    }
    if (newPassword != confirmPassword) {
      EasyLoading.showToast("两次密码输入的不一致");
      return;
    }
    var requestData = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "rawPassword": confirmPassword
    };
    EasyLoading.show(status: "修改中...");
    var resp = await updatePassword(requestData);
    print("打印响应： $resp");
    if (resp["code"] == 200) {
      EasyLoading.dismiss();
      Get.back();
      Get.snackbar("系统提示", resp["msg"]);
    } else {
      EasyLoading.dismiss();
      Get.snackbar("系统提示", resp["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("修改密码"),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    child: Text(
                      "旧密码",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: TextField(
                        obscureText: true,
                        textAlignVertical: const TextAlignVertical(y: 1),
                        decoration: const InputDecoration(
                            hintText: "请输入旧密码",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)))),
                        onChanged: (value) {
                          oldPassword = value;
                        },
                      ))
                ],
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    child: Text(
                      "新密码",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: TextField(
                        obscureText: true,
                        textAlignVertical: const TextAlignVertical(y: 1),
                        decoration: const InputDecoration(
                            hintText: "请输入新密码",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)))),
                        onChanged: (value) {
                          newPassword = value;
                        },
                      ))
                ],
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "确认密码",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: TextField(
                        obscureText: true,
                        textAlignVertical: const TextAlignVertical(y: 1),
                        decoration: const InputDecoration(
                            hintText: "请输入新密码",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)))),
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                      ))
                ],
              ),
            ),
            Container(
              height: 50,
              width: 400,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: TextButton(
                child: const Text(
                  "提交",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _submit();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
