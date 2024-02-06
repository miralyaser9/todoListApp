
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:todolistfirsbase1/views/edit_page.dart';

import 'package:todolistfirsbase1/widgets/dialog-view.dart';

import '../helpers/cloudfirestore.dart';
import '../models/task-model.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFEEFA),
        elevation: 10,
        title: const Text(
          "Your Tasks",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            opacity: 0.5,
            image: NetworkImage(
                "https://www.shutterstock.com/image-vector/3d-white-clipboard-task-management-600nw-2107211819.jpg"),
          ),
        ),
        child: StreamBuilder<List<Task>>(
          stream: CloudFireStore().getTasks(),
          builder: (context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              tasks = snapshot.data!; // Update the local tasks list
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      subtitle: Text(tasks[index].status!,style: TextStyle(fontSize: 12),),
                      leading: Text(
                        tasks[index].title,
                        style: const TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      title: Text(
                        tasks[index].desc,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [

                          Text(DateFormat('dd/MM/yyyy').format(tasks[index].dueTime!)),

                          IconButton(
                            onPressed: () {
                              CloudFireStore()
                                  .deleteTask(taskTitle: tasks[index].title);
                            },
                            icon: const Icon(Icons.delete, color: Colors.pink),
                          ),
                          IconButton(
                            onPressed: () async {

                              Get.to(
                                  EditTaskScreen(
                                taskTitle: tasks[index].title, taskDesc: tasks[index].desc,
                                taskPriority: tasks[index].priorityLevel!, taskStatus:tasks[index].status!,));
                            },
                            icon: const Icon(Icons.edit, color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,
        onPressed: (){

          viewDialog(context);
        },
        child:
        const Icon(Icons.add),
      ),
    );
  }
}

