import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistfirsbase1/views/login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyC2-4A2ZU7LwGim-uQS9VotqB6yZpmcdmI",
        appId: "1:605913958351:android:10aa30af1ab72ad299f4ba",
        messagingSenderId: "605913958351",
        projectId: "todolist-71f4c")
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      home:LoginPage()
    );
  }
}


