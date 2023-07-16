import 'package:app/screens/home_screen.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'controllers/data_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  loadData() async {
  await Get.find<DataController>().getTasks();
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(DataController());
    loadData();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
