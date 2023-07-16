import 'package:app/controllers/data_controller.dart';
import 'package:app/screens/all_task.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/error_warning_ms.dart';
import 'package:app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();
    bool _dataValidation() {
      if (nameController.text.trim() == '') {
        Message.taskErrorOrWarning("Task Name", "Task name is empty!");
        return false;
      } else if (detailController.text.trim() == '') {
        Message.taskErrorOrWarning("Task Details", "Task details are empty!");
        return false;
      }
      // else if (nameController.text.length <= 10) {
      //   Message.taskErrorOrWarning("Task Name", "Task name must be atleast 10 characters!");
      //   return false;
      // }
      // else if (detailController.text.length <= 10) {
      //   Message.taskErrorOrWarning("Task Details", "Task details must be atleast 10 characters!");
      //   return false;
      // }
      return true;
    }

    return Scaffold(
        body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(color: Colors.yellow.shade300),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 60),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.indigo.shade900,
                    ))
              ],
            ),
            Column(
              children: [
                TextFieldWidget(
                  textController: nameController,
                  hintText: "Task Name",
                  borderRadius: 30,
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  textController: detailController,
                  hintText: "Task Details",
                  borderRadius: 30,
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    if(_dataValidation()){
                      Get.find<DataController>().pushTasks(nameController.text, detailController.text);
                      Get.to(() => const AllTask(),
                      transition: Transition.circularReveal);
                    }
                  },
                  child: const ButtonWidget(
                      bgcolor: Colors.black, text: "Add", textColor: Colors.white),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 6)
          ]),
    ));
  }
}
