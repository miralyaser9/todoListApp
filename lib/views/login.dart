import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolistfirsbase1/views/reset-pass.dart';
import 'package:todolistfirsbase1/views/sign-up.dart';

import '../controller/task-controller.dart';
import '../helpers/auth.dart';
import 'home-page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationHelper auth = AuthenticationHelper();
  TaskController taskController=Get.put(TaskController());

  GlobalKey<FormState> formKey=GlobalKey();
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      final double screenWidth = MediaQuery.of(context).size.width;
      final double screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(


        body: Container(decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [


                  SizedBox(height: screenHeight*0.1,),
                  const Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Login",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  )
                  ,  SizedBox(height: screenHeight*0.1,)
                  ,TextFormField( validator: (data){
                    if(data!.isEmpty){
                      return "this field is required";
                    }
                  },
                    onChanged: (value){
                      email=value;
                    }

                    ,decoration: InputDecoration(
                        labelText: "Email"
                        ,hintText: "enter your email",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(15)
                        ),
                        prefixIcon: Icon(Icons.mail,color: Colors.pinkAccent,)
                        ,focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(16)
                    )
                    ),



                  ),
                  const SizedBox(height: 20,),
                  Obx(()=>
                      TextFormField(
                        validator: (data){
                          if(data!.isEmpty){
                            return "this field is required";
                          }
                        },
                        obscureText:taskController.isVisible.value ,

                        decoration: InputDecoration(hintText: "enter your password",
                            labelText: "Password"
                            ,
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(15)
                            ),
                            prefixIcon: Icon(Icons.lock,color: Colors.pinkAccent,)
                            ,suffixIcon: IconButton(onPressed: () { taskController.passVisible();

                            }
                              ,icon: Icon(taskController.isVisible.value?Icons.visibility_off:Icons.visibility),


                            )
                            ,focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(16)
                            )
                        ),
                        onChanged: (value){
                          pass=value;
                        }
                        ,

                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 250),
                    child: TextButton(onPressed: (){
                      Get.to(ResetPass());

                    }, child:  Text("Reset password?",style:
                    TextStyle(fontSize:screenWidth*0.03,decoration: TextDecoration.underline,color: Colors.black),)
                    ),
                  )
                  ,const SizedBox(height: 30,
                  )
                  ,Center(child:
                  InkWell(onTap: ()async{

                    if(formKey.currentState!.validate()){

                      try {
                        await auth.signIn(email: email!, password: pass!);
                        Get.snackbar("note", "Success!");
                        Get.to(HomePage());

                      } on FirebaseAuthException catch (e) {
                        AuthStatus status;
                        switch (e.code) {

                          case "invalid-email":
                            status = AuthStatus.invalidEmail;
                            Get.snackbar("note", "${status}");

                            break;
                          case "wrong-password":
                            status = AuthStatus.wrongPassword;
                            Get.snackbar("note", "${status}");
                            break;
                          case "weak-password":
                            status = AuthStatus.weakPassword;
                            Get.snackbar("note", "${status}");
                            break;
                          case "email-already-in-use":
                            status = AuthStatus.emailAlreadyExists;
                            Get.snackbar("note", "${status}");
                            break;
                          default:
                            status = AuthStatus.unknown;
                            Get.snackbar("note", "${status}");
                        }
                      }

                      catch (e) {
                        print(e);
                      }
                    }
                  },
                    child: Container(width: 150,
                      decoration: BoxDecoration(color: Colors.pink,
                        borderRadius: BorderRadius.circular(16)
                        ,
                      ),
                      child: const Center(
                        child: Text("Login",style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,fontSize: 25),),
                      ),
                    ),
                  )
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not have account?",style: TextStyle(fontSize: 20,decorationStyle: TextDecorationStyle.dashed),),
                      Text("sign up",style: TextStyle(fontSize: 20,decorationStyle:
                      TextDecorationStyle.double,color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });

  }
}
