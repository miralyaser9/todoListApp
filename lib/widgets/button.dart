import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key,required this.buttonName,required this.ontabb}) : super(key: key);
  String buttonName;
  VoidCallback ontabb;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: ontabb,
      child: Container(
        width: double.infinity,height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),gradient:
        LinearGradient(colors: [Colors.blueAccent,Colors.white],begin: Alignment.centerRight,end: Alignment.centerLeft)
            ),
        child: Center(child: Text(buttonName,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}
