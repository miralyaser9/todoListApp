import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateFunction {
  DateTime dueDate = DateTime.now();

  Future<DateTime?> selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    return picked;
  }
}