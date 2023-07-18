import 'package:app/controllers/data_controller.dart';
import 'package:app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewTask extends StatefulWidget {
  final String id;
  const ViewTask({super.key, required this.id});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  String taskName = "";
  String taskDetail = "";
  int unixTimestamp = 0;
  String formattedDateTime = "";
  bool loadState = false;

  @override
  void initState() {
    super.initState();
    String taskID = widget.id;
    loadSingleTask(taskID);
  }

  Future<void> loadSingleTask(String id) async {
    print("in view $id");
    var controller = Get.find<DataController>();
    await controller.getTask(id);
    taskName = controller.singleTask['TaskName'];
    taskDetail = controller.singleTask['TaskDetail'];
    unixTimestamp = controller.singleTask['Created'];
    //convert unix time
    int unixTimeInMilliseconds = unixTimestamp ~/ 1000000;
    DateTime localDateTime =
        DateTime.fromMicrosecondsSinceEpoch(unixTimeInMilliseconds * 1000);
    DateTime localDateTimeWithMinutes = DateTime(
      localDateTime.year,
      localDateTime.month,
      localDateTime.day,
      localDateTime.hour,
      localDateTime.minute,
    );

    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(localDateTimeWithMinutes);
    //Update UI
    setState(() {});
    loadState = true;
  }

@override
Widget build(BuildContext context) {
    if(loadState){
      return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(color: Colors.red.shade500),
        padding: const EdgeInsets.only(left: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.indigo.shade900,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height / 14,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(0)),
                        child: Center(
                          child: Text(
                            taskName,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.only(left: 20, right: 20, top:10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(
                            taskDetail,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              
                            ),
                          ),
                          ]
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Created on: $formattedDateTime",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                        ),)
                    ],
                  ))
            ]),
      ),
    );
    }else{
      return const LoadingPage();
    }
}
}