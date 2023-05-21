import 'package:flutter/material.dart';
import 'package:to_do_list/my_button.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                hintText: " Add a new task ",
              ) ,
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(text: "Save", onPressed:onSave),
                const SizedBox(width: 15,),
                MyButton(text: "Cancel", onPressed:onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
