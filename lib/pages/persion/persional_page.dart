import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 个人信息页面
class PersionalPage extends StatefulWidget {
  const PersionalPage({Key? key}) : super(key: key);

  @override
  State<PersionalPage> createState() => _PersionalPageState();
}

class _PersionalPageState extends State<PersionalPage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Get.arguments as Map;

    return Scaffold(
        appBar: AppBar(
          title: const Text("个人信息"),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("昵称"),
                  trailing: Text(userInfo["userInfo"]["data"]["nickName"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text("手机号码"),
                  trailing: Text(userInfo["userInfo"]["data"]["phonenumber"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: const Text("邮箱"),
                  trailing: Text(userInfo["userInfo"]["data"]["email"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.tune_outlined),
                  title: const Text("部门"),
                  trailing:
                      Text(userInfo["userInfo"]["data"]["dept"]["deptName"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.how_to_reg_outlined),
                  title: const Text("岗位"),
                  trailing: Text(userInfo["userInfo"]["postGroup"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.people_outline),
                  title: const Text("角色"),
                  trailing: Text(
                      userInfo["userInfo"]["data"]["roles"][0]["roleName"]),
                ),
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222)),
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(255, 226, 222, 222))),
                ),
                child: ListTile(
                  leading: const Icon(Icons.event_available_outlined),
                  title: const Text("创建时间"),
                  trailing: Text(userInfo["userInfo"]["data"]["createTime"]),
                ),
              ),
            ],
          ),
        ));
  }
}
