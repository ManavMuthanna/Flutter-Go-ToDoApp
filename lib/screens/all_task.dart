import 'package:app/controllers/data_controller.dart';
import 'package:app/screens/add_task.dart';
import 'package:app/screens/view_task.dart';
import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTask extends StatelessWidget {
  const AllTask({super.key});
  loadData() async {
    await Get.find<DataController>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    final controller = Get.find<DataController>();
    List<dynamic> response = controller.myData;
    List<String> myData =
        response.map((data) => data['TaskName'] as String).toList();
    List<int> idList =
        response.map((data) => data['ID'] as int).toList();

    String tasks = idList.length.toString();
    print(idList);
    print(myData);

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

    return Scaffold(
        backgroundColor: Colors.green.shade300,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 20, top: 60),
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Get.back();
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
                          Get.to(()=>const AddTask(), transition: Transition.fade, duration: const Duration(seconds: 1));
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
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
                              backgroundColor: Colors.transparent,
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
                                          const ButtonWidget(
                                              bgcolor: Colors.white,
                                              text: "Edit",
                                              textColor: Colors.black),
                                        ]));
                              });
                          return false;
                        } else {
                          return Future.delayed(const Duration(seconds: 1),
                              () => direction == DismissDirection.endToStart);
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
        ));
  }
}
