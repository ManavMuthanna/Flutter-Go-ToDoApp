import 'package:app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.blue.shade300,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "Hello, ",
                    style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: "\nWhat are you doing today?",
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontSize: 25,
                      ))
                ])),
            SizedBox(height: MediaQuery.of(context).size.height/2),
            const ButtonWidget(bgcolor: Colors.black, text: "Add Task", textColor: Colors.white),
            const SizedBox(height: 20),
            const ButtonWidget(bgcolor: Colors.white, text: "View Tasks", textColor: Colors.black)       
          ]),
    ));
  }
}
