import 'package:flutter/cupertino.dart';

class Task{

  String title;
  final String? taskId;
  String desc;
  int? priorityLevel;
  String? status;
  String? userId;
  DateTime? dueTime;

  Task({required this.title,required this.desc,this.priorityLevel, @required this.status, this.dueTime, this.userId,@required this.taskId});
}