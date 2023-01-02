import 'package:flutter/material.dart';

class PersionPage extends StatefulWidget {
  const PersionPage({Key? key}) : super(key: key);

  @override
  State<PersionPage> createState() => _PersionPageState();
}

class _PersionPageState extends State<PersionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("我的"),
    );
  }
}
