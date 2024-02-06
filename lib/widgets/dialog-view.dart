

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/cloudfirestore.dart';
import '../models/task-model.dart';
import 'custom_textfield.dart';
import 'date_picker.dart';

void viewDialog(BuildContext context) {
  FirebaseAuth u = FirebaseAuth.instance;
  String? title;
  String? desc;
  int priorityLevel = 0;
  String status="" ;
  DateTime ? dueDate;

  Get.dialog(
    AlertDialog(
      title: const Text("Add a new Task"),
      content: Container(
        width: 300,
        height: 300,
        child: ListView(
          children: [
            CustomTextField(
              hintText: "enter a title",
              label: "title",
              suffixIcon: const Icon(Icons.paste_outlined),
              oncahnged: (value) {
                title = value;
              },
            ),
            const SizedBox(height: 20,),
            CustomTextField(
              hintText: "enter desc",
              label: "desc",
              suffixIcon: const Icon(Icons.notes_rounded),
              oncahnged: (value) {
                desc = value;
              },
            ),const SizedBox(height: 20,),

            CustomTextField(
              hintText: "write status",
              label: "status",
              suffixIcon: const Icon(Icons.cloud_download_rounded),
              oncahnged: (value) {

                status = value;
              },
            ),
            const SizedBox(height: 20,),
            CustomTextField(
              hintText: "enter priority",
              label: "priority",
              suffixIcon: const Icon(Icons.notes_rounded),
              oncahnged: (value) {
                if (value.isNotEmpty) {
                  priorityLevel = int.parse(value);
                }
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton( style: const ButtonStyle(backgroundColor:
            MaterialStatePropertyAll(Colors.pinkAccent)),
              onPressed: ()async {

              DateTime? selectedDate=await DateFunction().selectDueDate(context);
              dueDate=selectedDate;


              },
              child: const Text("Select due date"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Close"),
        ),
        TextButton(
          onPressed: () {
            CloudFireStore().addNewTask(
              task: Task(
                title: title!,
                desc: desc!,
                priorityLevel: priorityLevel,
                status: status,
                dueTime: dueDate,
                userId: u.currentUser!.uid,
              ),
            );
            Get.back();
          },
          child: const Text("Submit"),
        ),
      ],
    ),
  );
}

