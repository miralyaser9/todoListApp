import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task-model.dart';

class CloudFireStore {
  CollectionReference tasks = FirebaseFirestore.instance.collection("tasks");
  FirebaseAuth u = FirebaseAuth.instance;


  Future<void> addNewTask({required Task task}) async {
    return tasks
        .add({
      "title": task.title,
      "desc": task.desc,
      'date': task.dueTime,
      'priorityLevel': task.priorityLevel,
      'status': task.status,
      'userId': u.currentUser!.uid
    })
        .then((value) => print("task added")
    )
        .catchError((error) => print("Failed to add Task: $error"));
  }

  Stream<List<Task>> getTasks() {
    return tasks
        .where('userId', isEqualTo: u.currentUser!.uid)
        .orderBy('priorityLevel', descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Task(
          title: doc['title'],
          desc: doc['desc'],
          priorityLevel: doc["priorityLevel"],
          status: doc["status"],
          userId: doc['userId'],
          dueTime: doc["date"].toDate(),

        );
      }).toList();
    });
  }

  Future<void> deleteTask({required String taskTitle}) async {
    try {
      final querySnapshot = await tasks.where("title", isEqualTo: taskTitle)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final taskId = querySnapshot.docs.first.id;
        await tasks.doc(taskId).delete();
        print("Task deleted");
      } else {
        print("Task not found");
      }
    } catch (error) {
      print("Failed to delete Task: $error");
    }
  }


  Future<void> editTask({required Task task}) async {
    await tasks
        .where('title', isEqualTo: task.title)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.size == 1) {

        var documentSnapshot = querySnapshot.docs[0];
        var documentId = documentSnapshot.id;

        print("Updating task with ID: $documentId");
        return tasks.doc(documentId).update({
          "title": task.title,
          "desc": task.desc,
          "priorityLevel": task.priorityLevel,
          "status": task.status,
        }).then((value) {
          print("Task updated successfully");
        }).catchError((error) {
          print("Failed to update Task: $error");
        });
      } else {
        print("Task not found or multiple tasks found");
      }
    }).catchError((error) {
      print("Failed to query for Task: $error");
    });
  }
}



