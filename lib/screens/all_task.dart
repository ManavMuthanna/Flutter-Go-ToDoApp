import 'package:app/controllers/data_controller.dart';
import 'package:app/screens/add_task.dart';
import 'package:app/screens/edit_task.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/view_task.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/loading.dart';
import 'package:app/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTask extends StatefulWidget {
  const AllTask({super.key});

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  bool loadState = false;
  List<String> myData = [];
  List<int> idList = [];
  String tasks = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

    Future<void> loadData() async {
    var controller = Get.find<DataController>();
    await controller.getTasks();
    List<dynamic> response = controller.myData;
    myData =
        response.map((data) => data['TaskName'] as String).toList();
    idList =
        response.map((data) => data['ID'] as int).toList();
    tasks = idList.length.toString();
    //update UI
    setState(() {});
    loadState = true;
  }

    Future<void> deleteData(String id) async {
    var controller = Get.find<DataController>();
    await controller.deleteTask(id);
    //update UI
    setState(() {});
    loadState = true;
  }

  //fix the error below
  @override
  Widget build(BuildContext context){
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.indigo.shade900.withOpacity(0.9),
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );

    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.red.shade600.withOpacity(0.9),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );

    if(loadState){
        return RefreshIndicator(
          child: Scaffold(
          backgroundColor: Colors.green.shade300,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 60),
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Get.to(()=>const HomeScreen(), transition: Transition.fadeIn, duration: const Duration(seconds: 1));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.indigo.shade900,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.5),
                            color: Colors.black),
                        child: InkWell(
                          onTap: (){
                            Get.to(()=>const AddTask(), transition: Transition.circularReveal, duration: const Duration(seconds: 1));
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(Icons.calendar_month_sharp,
                          color: Colors.indigo.shade900),
                      const SizedBox(width: 8),
                      Text(
                        tasks,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  )),
              Flexible(
                child: ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: leftEditIcon,
                        secondaryBackground: rightDeleteIcon,
                        onDismissed: (DismissDirection direction) {},
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            showModalBottomSheet(
                                backgroundColor: Colors.purple.shade300,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Container(
                                      height:
                                          MediaQuery.of(context).size.height / 3,
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                String parseID = idList[index].toString();
                                                Get.off(() => ViewTask(id: parseID),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
                                              },
                                              child: const ButtonWidget(
                                                  bgcolor: Colors.black,
                                                  text: "View Details",
                                                  textColor: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                String parseID = idList[index].toString();
                                                Get.off(() => EditTask(id: parseID),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
                                              },
                                              child: const ButtonWidget(
                                                  bgcolor: Colors.white,
                                                  text: "Edit",
                                                  textColor: Colors.black),
                                            ),
                                          ]));
                                });
                            return false;
                          } else {
                            String parseID = idList[index].toString();
                            await deleteData(parseID);
                            loadState = false;
                            const LoadingPage();
                            await loadData();
                             // Assuming you have a deleteTask function that takes the task ID
                            return true; // Indicate that the dismiss action is confirmed
                          }
                        },
                        key: ObjectKey(index),
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: TaskWidget(
                                text: myData[index], color: Colors.black)),
                      );
                    }),
              )
            ],
          )),
          onRefresh: () async {
            loadState = false;
            const LoadingPage();
            await loadData();
          },
        );
    }else{
      loadState = false;
      loadData();
      return const LoadingPage();
    }
  }
}

//pull down to refresh page in dart?

