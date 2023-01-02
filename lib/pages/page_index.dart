import 'package:flutter/material.dart';
import 'home/home_page.dart';
import 'work/work_page.dart';
import 'persion/persion_page.dart';

class PageIndex extends StatefulWidget {
  const PageIndex({Key? key}) : super(key: key);

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  final List<BottomIndex> _pagesLists = [
    BottomIndex("首页", const HomePage()),
    BottomIndex("工作台", const WorkPage()),
    BottomIndex("我的", const PersionPage())
  ];

  int _pageIndex = 0;
  String _title = "";

  @override
  void initState() {
    super.initState();
    _title = _pagesLists[_pageIndex].name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _pagesLists[_pageIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "工作台"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
        ],
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
            _title = _pagesLists[_pageIndex].name;
          });
        },
      ),
    );
  }
}

class BottomIndex {
  final String name;

  final dynamic widget;

  BottomIndex(this.name, this.widget);
}
