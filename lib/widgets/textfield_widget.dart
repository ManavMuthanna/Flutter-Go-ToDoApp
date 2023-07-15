import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double borderRadius;
  final int? maxLines;
  const TextFieldWidget({super.key, required this.textController, required this.hintText, required this.borderRadius, this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return  TextField(
              maxLines: maxLines,
              controller: textController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                hintText: hintText,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: const BorderSide(color: Colors.black, width: 1)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius), borderSide: const BorderSide(color: Colors.black, width: 1))
              ),
            );
  }
}