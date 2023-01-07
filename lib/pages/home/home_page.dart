import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());

    // return Container(
    //   alignment: Alignment.center,
    //   child: Image.asset("static/logo.png"),
    // );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(() => Text("Clicks: ${controller.count}")),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: (() {
                Get.to(() => const OtherPage());
              }),
              child: const Text("路由"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text("其他页面"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text("Count: ${controller.count}")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (() {
                controller.increment();
              }),
              child: const Text("add"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: (() {
                Get.back();
              }),
              child: const Text("返回"),
            )
          ],
        ),
      ),
    );
  }
}
