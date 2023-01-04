import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/api/login_api.dart';
import 'package:ruoyi_app/router/app_router_constant.dart';
import 'package:ruoyi_app/utils/sputils.dart';

import '../../api/menu_api.dart';

/// 登录页面
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String uuid = "";
  String password = "";
  String username = "";

  /// 给初始值， 防止图片加载慢渲染报错
  String code = "";
  String imgCode =
      "/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAA8AKADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDtrW1ga1hZoIySikkoOeKsCztv+feL/vgU2z/484P+ua/yqyKiMY8q0IjGPKtCIWdr/wA+0P8A3wKeLK1/59of+/YqUUpdUHzMB25NPkj2Hyx7EYsrT/n1h/79inCxtP8An1g/79isrVvFmi6JEXvL6IN2iQ7nP4D+vFbFpcLdW0U6gqsiBwG6jIzzWksPKMVOUbJ7O24csewCws/+fWD/AL9inCws/wDn0g/79ipxThWfLHsHLHsQjT7L/n0t/wDv2P8ACnDTrL/nzt/+/S/4VI8iRIWdgqjqScCuN8Q/FDQ9Dk8iJ/t1wOqQMCF+rdK6MNgquJnyUYcz8kJqEdWdiNOsf+fO3/79L/hThptj/wA+Vv8A9+l/wrC8JeM9P8WWjy22YpoziSBzyvofcV0681FbDSoVHTqxtJdBpRaukVxplh/z5W3/AH6X/CnjTLD/AJ8bb/v0v+FWBSlgo5rLlj2Dlj2IBpen/wDPjbf9+V/wp40rT/8Anwtf+/K/4VwHiP4waRot81lZwyX8sZxI8ZAjX1APc11fhXxdpvivTvtdi5BU7ZIXxvjPuBXbVyzEUaKr1KbUX1JXI3ZGsNK07/nwtf8Avyv+FOGk6d/0D7X/AL8r/hVoU8VxcsexXLHsVRpOm/8AQPtP+/K/4VW1PS9Pj0i9dLG1V1gcqwhUEHaeRxWsKq6t/wAgW/8A+veT/wBBNKUY8r0FKMeV6HJWf/HnB/1zX+VWRVez/wCPOD/rmv8AKrIpx+FDj8KF7Vy3je3k1Dw/cWkThZGwyEnAyK6oCs/UbAXURFbUqsqVSNSO6d/uG1dWPnPUtOuLLa9xJvdjg85x+Ne9eCdXXVPD9nMGyREEb2ZRg/qK4nxJ4Zyjgjg9/SsTwR4gk8M6zJpl8222nbAY9EfoD9D0P4V9PWxE85wLv/FpNuy6xe9vT9PMxS9nLyZ7be6j5GmT3NoqXEiIxRN+AxHbPauc8N+P7S/8NNqWqSRW00UjJLGvABzkAA89MfrXKa9pl1aXtxf6Pq01n553ywnlCfUV5hcySNcTlpPMDSZcrwrH1xSyrKMLjacoKpr7rvZprvF3016NMJ1JRex73r2o2virwhP/AGZdBknQhGBwQw7HuK8tOjadoluWvts0rDkvwPoBW58PYrFmkW1vJA7qPNtZD39cf1HrWx4u8Nw31oAykMp3Ky9RXLOs8DXlg1UlGk3d2Vpf16aPcq3Mua2pwXgnWxovjGGaJmFtM5iZc/wnp+RxX0LPr2nadZG5vbyKGNRyXYCvm86TcaddC4ii89YmyY2HJArcv7rRfFUkV7PPNbywR4mg7sB3B/wr0syp4XMasMVBv2aVpNK7utk1um9r2tsRBygnF7np8Pxe8Ly3vkGeZEJwJWjIX/61b+p31vquizCzuUljniKh42zwR7V4D9t8Ly/6ObFo06CUE7vrmui8H6WdM1eO8sdahawbiWKU4yp/HGfeuPGZbhaUOeHPTktlNaS9Gtn6lRnJvXUbHoNp4f0xxcQpNIVJmlcdfYe1YngLxAdB8ZxNEzLZ3LmJ0z2J+X8jivTvE9hbanoEpgkR45kO2RDkfnXjGj2wi8R20Fz8hWYA56ZzXdk9ZYqhinipOUmtV5a6peT+7QmouVx5T62tZRLGGHerIrH0Ny9mmfStkV8WdA4VV1b/AJAl/wD9e0n/AKCatiqur/8AIEv/APr2k/8AQTUy+Fky+FnJWf8Ax5Qf9c1/lVkVXsv+PKD/AK5r/KrIoj8KCPwocKdjNIKeKoowdftBLZyBTtYqcNjOD618/axBqKXcgvQzlGI8wLwR6j2r6Vvbfz4SvrXn2teFHllMiLXqZXmksvqOcYKV++/yfQicOdWODtvGJ/sP7DeQPNIq7FkD4yvbPuKbY6Il5pyTQKxjfOd3XNdFb+EkFyGks42IPdf6V32n6GGtgrIOnpW+OzLD1I2wkHBt8z10uuy9degowa+J3PItJ06P+0xpl48ttcfetbuMlW+nvXptlpN0fDk1hf6nNcyOTsueQ6A9PyNXv+EaQ3AJjBwcjI6Gt1dLxb7cdqwxma1cTa+mzez1XVaXV92trjjBI8Nnv9V8PXhg1aH7RFuIWYD73uD3+hrAvbqK51hZ7GMoWYfKB1P0r2PXtAkmR0aMOjdVIyDXOaT4NWK+DrAAc9cdK9PCZ3hKXNVlRtUaa93SL9V0+REqcnpfQzD4ZtJ4P+PMKSM5UnINZyeC5nn8uO9KQsecqSQPpnmvcrDw9F9mVWQZxT/+EYh8zcFFeXh85x2HvyVHr31/O5bpxe6Oe8O+HYdP8PCwgkmlTJYmU55PXA7D2rj/ABJ4Vjh8y7e1aRovm/dttbA9DXtlnpyQR7QKztX0oSqSqg/hXNTxlWFf6xzPmvd62v327jcU1Ywvhn4vtfEFhJbKjxXFrhWSRssy9mr0ZeRXFeGtGh0oslraxQKxy3loBuPqfWu0jHyipxU6U60pUY8sXsm7jimlqSCqur/8gS//AOvaT/0E1bFVdX/5Al//ANe0n/oJrll8LFL4WclZf8eVv/1zX+VWRXMxa1cxRJGqREIoUZB7fjUn9v3X/POH/vk/41lGtGyM41Y2R0opwrmf+Ehu/wDnnB/3yf8AGl/4SK7/AOecH/fJ/wAar20R+2idQBmmtbo45Armv+EkvP8AnlB/3yf8aX/hJbz/AJ5Qf98n/Gj20Q9tE3xp0O7OwVbjhVBgCuW/4Se9/wCeVv8A98t/jS/8JRe/88rf/vlv8aPbRD20TrBEuc4qUKMVx/8AwlV9/wA8rf8A75b/ABpf+Ervv+eVt/3y3+NHtoh7aJ1clpHKPmUUyLTYUbIQVzH/AAlt/wD88bb/AL5b/Gl/4S/UP+eNt/3y3/xVHtoh7aJ2iIFGAKlAFcP/AMJhqH/PG1/75b/4ql/4TLUf+eNr/wB8t/8AFUe2iHtondAUNEHGCK4b/hM9R/542v8A3w3/AMVS/wDCa6l/zwtP++G/+Ko9tEPbRO4jt0Q5AqworgP+E21L/nhaf98N/wDFUv8AwnGp/wDPC0/74b/4qj20Q9tE9BFVdX/5Aeof9e0n/oJriv8AhOdT/wCeFp/3w3/xVR3PjPUbq1mt3htQkqMjFVbIBGOPmqZVo2YpVY2Z/9k=";

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  /// 获取验证码
  void _getImages() async {
    var result = await getImage();
    setState(() {
      uuid = result["uuid"];
      imgCode = result["img"];
    });
  }

  /// 登录
  void _login() async {
    if (username.isEmpty) {
      EasyLoading.showToast("用户名不能为空！");
      return;
    }
    if (password.isEmpty) {
      EasyLoading.showToast("密码不能为空！");
      return;
    }
    if (code.isEmpty) {
      EasyLoading.showToast("验证码不能为空！");
      return;
    }
    var requestData = {
      "uuid": uuid,
      "username": username,
      "password": password,
      "code": code
    };

    EasyLoading.show(
      status: "加载中...",
    );

    var loginResp = await login(requestData);
    if (loginResp["code"] == 200) {
      String token = loginResp["token"];
      GetStorage().write("token", token);
      SPUtil().setString("token", token);

      /// 查询路由
      var routers = await getRouters();
      if (routers["code"] == 200) {
        List<dynamic> routerListData = routers["data"];
        GetStorage().write("routers", routerListData);
      }

      /// 查询用户信息
      var getUserInfo = await getInfo();
      if (getUserInfo["code"] == 200) {
        GetStorage().write("userInfo", getUserInfo);
      }
      EasyLoading.dismiss();
      Get.toNamed(AppRouterConstant.Home);
    } else {
      setState(() {
        _getImages();
      });
      EasyLoading.dismiss();
      EasyLoading.showToast(loginResp["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("登录")),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("static/logo.png"),
                    const Text(
                      "若依移动端登录",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: TextField(
                    onChanged: (value) => username = value,
                    decoration: const InputDecoration(
                        hintText: "请输入用户名",
                        icon: Icon(Icons.person),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    decoration: const InputDecoration(
                        hintText: "请输入密码",
                        icon: Icon(Icons.lock),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextField(
                          onChanged: (value) => code = value,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "请输入验证码",
                              icon: Icon(Icons.beenhere_outlined),
                              border: InputBorder.none),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          child: Container(
                            height: 50,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25.0),
                                    bottomRight: Radius.circular(25.0))),
                            child: Image.memory(
                                const Base64Decoder().convert(imgCode),
                                fit: BoxFit.fill),
                          ),
                          onTap: () {
                            _getImages();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 10),
                child: Container(
                  height: 50,
                  width: 400,
                  padding: const EdgeInsets.all(1),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0))))),
                    child: const Text(
                      "登录",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      _login();
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("登录即代表同意"),
                  InkWell(
                    child: const Text(
                      "《用户协议》",
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      print("点击用户协议。。。");
                    },
                  ),
                  InkWell(
                    child: const Text(
                      "《用户隐私》",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      print("点击用户协议。。。");
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
