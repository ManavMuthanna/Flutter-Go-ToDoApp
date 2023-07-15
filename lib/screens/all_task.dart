import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTask extends StatelessWidget {
  const AllTask({super.key});

  @override
  Widget build(BuildContext context) {
    List myData = ["Try harder", "Try Smarter"];
    
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.indigo.shade900.withOpacity(0.9),
      alignment: Alignment.centerLeft,
      child: const Icon(Icons.edit, color: Colors.white,),
    );
    
    final rightDeleteIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.red.shade600.withOpacity(0.9),
      alignment: Alignment.centerRight,
      child: const Icon(Icons.delete, color: Colors.white,),
    );

    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Column(
        children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 20, top: 60),
          alignment: Alignment.topLeft,
          child: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back, color: Colors.indigo.shade900,)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height/7,),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(children: [
            Icon(Icons.home, color: Colors.indigo.shade900),
            const SizedBox(width: 10),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.5), color: Colors.black),
              child: const Icon(Icons.add, color: Colors.white, size: 20,),
            ),

            Expanded(child: Container()),
            Icon(Icons.calendar_month_sharp, color: Colors.indigo.shade900),
            const SizedBox(width: 8),
            const Text("2", style: TextStyle(fontSize: 20, color: Colors.white), )
          ],)
        ),

      Flexible(
        child: ListView.builder(itemCount: myData.length, itemBuilder: (context, index) {
          return Dismissible(
            background: leftEditIcon,
            secondaryBackground: rightDeleteIcon,
            onDismissed: (DismissDirection direction){

            },
            confirmDismiss: (DismissDirection direction)async{
              if(direction==DismissDirection.startToEnd){
                showModalBottomSheet(
                backgroundColor: Colors.transparent,
                barrierColor: Colors.transparent,
                context: context, 
                builder: (_){
                  return Container(
                    height: MediaQuery.of(context).size.height/3,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(bgcolor: Colors.black, text: "View Details", textColor: Colors.white),
                        SizedBox(height: 20,),
                        ButtonWidget(bgcolor: Colors.white, text: "Edit", textColor: Colors.black),
                      ]
                    )
                  );
                });
                return false;
              }else{
                return Future.delayed(const Duration(seconds: 1), ()=>direction==DismissDirection.endToStart);
              }
            },
            key: ObjectKey(index),
            child: Container(
              margin: const EdgeInsets.only(left:20, right:20, bottom: 10),
              child: TaskWidget(text: myData[index], color: Colors.black)),
          );
        }),
      )
      
      ],)
    );
  }
}

