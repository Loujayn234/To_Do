// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do/utilities/savebutton.dart';
import 'package:to_do/utilities/cancelbutton.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 150,
        //enter task
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                hintText: "Add New Task!",
                hintStyle: TextStyle(color: Colors.grey[300])),
          ),
          //buttons --> save & -->cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //save
              Savebutton(text: 'Save', onPressed: onSave),

              //cnacel
              Cancelbutton(text: 'Cancel', onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
