import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message{
  static void taskErrorOrWarning(String taskName, String taskErrorOrWarning){
    Get.snackbar(taskName, taskErrorOrWarning,
      backgroundColor: Colors.red,
      titleText: Text(
        taskName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
        )
      ),
      messageText: Text(
        taskErrorOrWarning,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white
        )
      ),
    );


  }
}