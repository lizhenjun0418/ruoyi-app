import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/user_api.dart';
import '../../router/app_router_constant.dart';

class PersionPage extends StatefulWidget {
  const PersionPage({Key? key}) : super(key: key);

  @override
  State<PersionPage> createState() => _PersionPageState();
}

class _PersionPageState extends State<PersionPage> {
  String username = "";

  @override
  void initState() {
    super.initState();

    String nickName = GetStorage().read("userInfo")["user"]["userName"];
    setState(() {
      username = nickName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      color: const Color.fromARGB(255, 228, 231, 228),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 12, 139, 242),
                // padding: const EdgeInsets.only(left: 5, right: 5),
                child: InkWell(
                  onTap: (() {
                    print("点击了");
                    getUserProfile().then(
                        (value) => {
                              if (value != null && value["code"] == 200)
                                {
                                  Get.toNamed(AppRouterConstant.persional,
                                      arguments: {"userInfo": value})
                                }
                            }, onError: (error) {
                      EasyLoading.showToast("系统繁忙");
                    });
                  }),
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.asset("static/images/profile.jpg"),
                    ),
                    title: Text(
                      "用户名：$username",
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 120,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 120),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.supervisor_account_rounded,
                          color: Colors.red,
                          size: 40,
                        ),
                        Text("用户交流")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.support_agent_outlined,
                          color: Colors.blue,
                          size: 40,
                        ),
                        Text("在线客服")
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.forum_outlined,
                          // color: Colors.red,
                          size: 40,
                        ),
                        Text("点赞我们")
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      children: const [
                        Icon(
                          Icons.thumb_up_outlined,
                          color: Colors.green,
                          size: 40,
                        ),
                        Text("用户交流")
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 288,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(children: [
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: const ListTile(
                  leading: Icon(
                    Icons.perm_identity_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("编辑资料"),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    // color: Colors.,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: const ListTile(
                  leading: Icon(
                    Icons.help_outline_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("常见问题"),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    // color: Colors.,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: const ListTile(
                  leading: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("关于我们"),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    // color: Colors.,
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 70,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0))),
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Colors.blue,
                  ),
                  title: const Text("应用设置"),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    // color: Colors.,
                  ),
                  onTap: () {
                    print("进来了");
                    Get.toNamed(AppRouterConstant.settings);
                  },
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
