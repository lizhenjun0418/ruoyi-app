import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/api/menu_api.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  List<dynamic> routerListData = [];

  int clickIndex = 0;

  @override
  void initState() {
    super.initState();

    /// 延迟获取路由信息
    Future.delayed(const Duration(seconds: 2), () => _queryRouters());
  }

  List<Map> imageList = [
    {"url": "static/images/banner/banner01.jpg"},
    {"url": "static/images/banner/banner02.jpg"},
    {"url": "static/images/banner/banner03.jpg"}
  ];

  /// 获取路由
  void _queryRouters() async {
    var routers = await getRouters();
    print(routers);
    if (routers["code"] == 200) {
      routerListData = routers["data"];
      GetStorage().write("routers", routerListData);
    }
  }

  /// 遍历下拉框
  List<PopupMenuEntry<String>> _getPopupmenus() {
    List<dynamic> routerList = GetStorage().read("routers");
    List<PopupMenuEntry<String>> popupMenuList = routerList.map((item) {
      String title = item["meta"]["title"];
      String name = item["name"];
      return PopupMenuItem(
        value: name,
        child: Text(title),
      );
    }).toList();
    return popupMenuList;
  }

  /// 遍历菜单信息
  List<SizedBox> _getRouterChildrens(clickIndex) {
    List<dynamic> childrens = [];
    var routerList = GetStorage().read("routers");
    if (routerList != null) {
      List<dynamic> routersList = routerList;
      for (int index = 0; index < routersList.length; index++) {
        if (index != clickIndex) {
          continue;
        }
        dynamic router = routersList[index];
        if (router["hidden"] != false) {
          continue;
        }
        var childrenList = router["children"];
        if (childrenList == null) {
          continue;
        }
        childrens = childrenList;
      }
    }
    List<SizedBox> routerChildrens = childrens.map((mapValue) {
      return SizedBox(
        height: 30,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "static/svg/${mapValue["meta"]["icon"]}.svg",
              height: 30,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(mapValue["meta"]["title"])
          ],
        ),
      );
    }).toList();
    return routerChildrens;
  }

  int _getClickIndexByPopUp(popupMenuValue) {
    int currentIndex = 0;
    List<dynamic> routers = GetStorage().read("routers");
    for (int i = 0; i < routers.length; i++) {
      String name = routers[i]["name"];
      if (popupMenuValue == name) {
        currentIndex = i;
        break;
      }
    }
    return currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 180,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                imageList[index]["url"],
                fit: BoxFit.fill,
              );
            },
            itemCount: imageList.length,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            loop: true,
            autoplay: true,
          ),
        ),
        Container(
          height: 50,
          margin:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
          decoration: const BoxDecoration(),
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: PopupMenuButton(
                    initialValue: GetStorage().read("routers")[clickIndex]
                        ["name"],
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.blue,
                    ),
                    itemBuilder: ((context) {
                      return _getPopupmenus();
                    }),
                    onSelected: (value) {
                      int currentIndex = _getClickIndexByPopUp(value);
                      setState(() {
                        clickIndex = currentIndex;
                      });
                    }),
              ),
              Text(
                GetStorage().read("routers")[clickIndex]["meta"]["title"],
                style: const TextStyle(fontSize: 20.0),
              )
            ],
          ),
        ),
        Container(
          height: 400,
          margin: const EdgeInsets.only(top: 10),
          child: GridView.count(
            crossAxisCount: 4, //每行三列
            crossAxisSpacing: 10.0, //显示区域宽高相等
            padding: const EdgeInsets.only(
                right: 10.0, bottom: 10.0, left: 10.0, top: 10.0),
            children: _getRouterChildrens(clickIndex),
          ),
        )
      ],
    );
  }
}
