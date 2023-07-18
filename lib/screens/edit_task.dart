import 'package:app/controllers/data_controller.dart';
import 'package:app/screens/all_task.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/widgets/textfield_widget.dart';
import 'package:app/widgets/error_warning_ms.dart';

class EditTask extends StatefulWidget {
  final String id;
  const EditTask({super.key, required this.id});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  bool loadState = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  String taskID = "";
  @override
  void initState() {
    super.initState();
    taskID = widget.id;
    loadSingleTask(taskID);
  }

  Future<void> loadSingleTask(String id) async {
    var controller = Get.find<DataController>();
    await controller.getTask(id);
    nameController.text = controller.singleTask['TaskName'] ?? '';
    detailController.text = controller.singleTask['TaskDetail'] ?? '';
    //Update UI
    setState(() {});
    loadState = true;
  }

  @override
  Widget build(BuildContext context) {
    bool dataValidation() {
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

    if (loadState) {
      return Scaffold(
        body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(color: Colors.orange.shade300),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                const SizedBox(height: 60),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.indigo.shade900,
                  ),
                )
              ]),
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
                    onTap: () {
                      if (dataValidation()) {
                        Get.find<DataController>().editTask(taskID, nameController.text, detailController.text);
                        Get.to(() => const AllTask(),
                            transition: Transition.circularReveal);
                      }
                    },
                    child: const ButtonWidget(
                        bgcolor: Colors.black,
                        text: "Update",
                        textColor: Colors.white),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 6)
            ]),
      ));
    } else {
      return const LoadingPage();
    }
  }
}
