import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,required this.hintText,required this.label,
    this.oncahnged,this.suffixIcon,this.onSubmit,this.controller,this.enabled}) : super(key: key);
  String hintText,label;
  Function(String)? oncahnged;
  Icon? suffixIcon;
  Function(String)? onSubmit;
  TextEditingController? controller;
  bool? enabled;

  @override
  Widget build(BuildContext context) {

    return TextField(controller: controller,
      enabled: enabled,

      onSubmitted: onSubmit,
      onChanged: oncahnged,
      decoration: InputDecoration(suffixIcon: suffixIcon,labelText: label,
          hintText: hintText,hintStyle: const TextStyle(color: Colors.white),
          enabledBorder:
          const OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(38)),borderSide: BorderSide(color: Colors.pinkAccent)
          )
          ,focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.pinkAccent))
      ),
    );
  }
}