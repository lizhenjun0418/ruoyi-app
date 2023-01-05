import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../api/user_api.dart';

/// 编辑资料页面
class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final userInfo = Get.arguments as Map;
  String sex = "1";
  String nickName = "";
  String phone = "";
  String email = "";
  bool isClickNickName = false;
  bool isClickPhone = false;
  bool isClickEmail = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _initData();
    });
  }

  void _initData() {
    nickName = userInfo["userInfo"]["data"]["nickName"] ?? "";
    phone = userInfo["userInfo"]["data"]["phonenumber"] ?? "";
    email = userInfo["userInfo"]["data"]["email"] ?? "";
    sex = userInfo["userInfo"]["data"]["sex"] ?? "1";
  }

  void _submit() {
    var user = userInfo["userInfo"]["data"];
    user["nickName"] = nickName;
    user["phonenumber"] = phone;
    user["email"] = email;
    user["sex"] = sex;
    updateProfile(user).then((resp) {
      print("更新用户信息，响应报文： $resp");
      if (resp["code"] == 200) {
        Get.back();
        Get.snackbar("", resp["msg"]);
      } else {
        EasyLoading.showToast(resp["msg"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("编辑资料"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  "用户昵称",
                  style: TextStyle(fontSize: 16),
                )),
                Expanded(
                  flex: 4,
                  child: TextField(
                    textAlignVertical: const TextAlignVertical(y: 1),
                    controller: TextEditingController.fromValue(
                        TextEditingValue(
                            text: nickName,
                            selection: TextSelection.fromPosition(TextPosition(
                                offset: nickName.length,
                                affinity: TextAffinity.downstream)))),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        hintText: "请输入昵称",
                        suffixIcon: IconButton(
                            onPressed: () {
                              if (isClickNickName) {
                                return;
                              }
                              setState(() {
                                nickName = "";
                                isClickNickName = true;
                              });
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: isClickNickName
                                  ? Colors.transparent
                                  : Colors.grey,
                            ))),
                    onChanged: (value) {
                      setState(() {
                        nickName = value;
                        if (nickName.isEmpty) {
                          isClickNickName = true;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  "手机号码",
                  style: TextStyle(fontSize: 16),
                )),
                Expanded(
                  flex: 4,
                  child: TextField(
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: phone,
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      offset: phone.length,
                                      affinity: TextAffinity.downstream)))),
                      textAlignVertical: const TextAlignVertical(y: 1),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          hintText: "请输入手机号码",
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (isClickPhone) {
                                  return;
                                }
                                setState(() {
                                  phone = "";
                                  isClickPhone = true;
                                });
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: isClickPhone
                                    ? Colors.transparent
                                    : Colors.grey,
                              ))),
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                          if (phone.isEmpty) {
                            isClickPhone = true;
                          }
                        });
                      }),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  "邮箱",
                  style: TextStyle(fontSize: 16),
                )),
                Expanded(
                  flex: 4,
                  child: TextField(
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: email,
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      offset: email.length,
                                      affinity: TextAffinity.downstream)))),
                      textAlignVertical: const TextAlignVertical(y: 1),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          hintText: "请输入邮箱",
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (isClickEmail) {
                                  return;
                                }
                                setState(() {
                                  email = "";
                                  isClickEmail = true;
                                });
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: isClickEmail
                                    ? Colors.transparent
                                    : Colors.grey,
                              ))),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                          if (email.isEmpty) {
                            isClickEmail = true;
                          }
                        });
                      }),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  "性别",
                  style: TextStyle(fontSize: 16),
                )),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        const Text(
                          "男",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                            value: "1",
                            groupValue: sex,
                            onChanged: ((value) {
                              setState(() {
                                sex = value as String;
                              });
                            })),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text("女", style: TextStyle(fontSize: 16.0)),
                        Radio(
                            value: "2",
                            groupValue: sex,
                            onChanged: ((value) {
                              setState(() {
                                sex = value as String;
                              });
                            }))
                      ],
                    ))
              ],
            ),
          ),
          Container(
            height: 50,
            width: 400,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: TextButton(
                onPressed: () {
                  _submit();
                },
                child: const Text(
                  "提交",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )),
          )
        ]),
      ),
    );
  }
}
