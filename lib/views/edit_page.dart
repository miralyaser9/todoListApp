
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolistfirsbase1/helpers/cloudfirestore.dart';
import 'package:todolistfirsbase1/models/task-model.dart';
import 'package:todolistfirsbase1/widgets/custom_textfield.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskTitle;
  final String taskDesc;
  final int taskPriority;
  final String taskStatus;



  const EditTaskScreen({Key? key, required this.taskTitle,required this.taskDesc,required this.taskPriority,required this.taskStatus}) : super(key: key);

  @override
  EditTaskScreenState createState() => EditTaskScreenState();
}

class EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  TextEditingController priorityEditingController = TextEditingController();
  TextEditingController statusEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleEditingController.text = widget.taskTitle;
    descEditingController.text=widget.taskDesc;
    priorityEditingController.text=widget.taskPriority.toString();
    statusEditingController.text=widget.taskStatus;
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    descEditingController.dispose();
    priorityEditingController.dispose();
    statusEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit  Your Task',style: TextStyle(color: Colors.black),),centerTitle: true, backgroundColor: const Color(0xffFFEEFA)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: titleEditingController, hintText: 'enter updated title', label: 'Title',

            ),
            const SizedBox(height: 10,)
            , CustomTextField(
              controller: descEditingController, hintText: 'enter updated desc', label: 'desc',

            ),
            const SizedBox(height: 10,),
            CustomTextField(
              controller: priorityEditingController, hintText: 'enter updated priority', label: 'Priority',

            ),
            const SizedBox(height: 10,),
            CustomTextField(
              controller: statusEditingController, hintText: 'enter updated status', label: 'Status',

            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: const ButtonStyle(backgroundColor:
              MaterialStatePropertyAll(Colors.pinkAccent)),
              onPressed: () {
                String updatedTaskTitle = titleEditingController.text;
                String updatedTaskDesc = descEditingController.text;
                int updatedTaskPriority = int.tryParse(priorityEditingController.text)??0;
                String updatedTaskStatus = statusEditingController.text;
                CloudFireStore().editTask(task: Task(title: updatedTaskTitle, desc: updatedTaskDesc,priorityLevel: updatedTaskPriority,status: updatedTaskStatus));


               Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

}