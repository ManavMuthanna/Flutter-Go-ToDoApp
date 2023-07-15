import 'package:app/widgets/button_widget.dart';
import 'package:app/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

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
            IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back, color: Colors.indigo.shade900,))
          ],
        ),
        Column(
          children: [
            TextFieldWidget(textController: nameController, hintText: "Task Name", borderRadius: 30, maxLines: 1,),
            const SizedBox(height: 20),
            TextFieldWidget(textController: detailController, hintText: "Task Details", borderRadius: 30, maxLines: 4,),
            const SizedBox(height: 20,),
            const ButtonWidget(bgcolor: Colors.black, text: "Add", textColor: Colors.white)
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/6
        )
      ]),
    ));
  }
}
