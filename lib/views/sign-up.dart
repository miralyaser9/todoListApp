
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolistfirsbase1/controller/task-controller.dart';
import 'package:todolistfirsbase1/views/home-page.dart';
import 'package:todolistfirsbase1/views/login.dart';

import '../helpers/auth.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
TaskController taskController=Get.put(TaskController());
  AuthenticationHelper auth = AuthenticationHelper();


  String? email;

  bool isVisible=true;

  String? pass;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {

    return
      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        final double screenWidth = MediaQuery.of(context).size.width;
        final double screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(

          body: Container(decoration: const BoxDecoration(
             ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child:

              Center(
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(height:screenHeight*0.1,),

                      const Row(
                        children: [
                          Text("Register", style: TextStyle(color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),),
                        ],
                      )
                      ,
                      SizedBox(height: screenHeight*0.1,),
                      TextFormField(
                        validator: (data){
                          if(data!.isEmpty){
                            return "this field is required";
                          }
                        },

                        decoration:
                        InputDecoration(suffixIcon: const Icon(Icons.email),hintText: "Enter an email",labelText: "Email",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),borderSide: const BorderSide(color: Colors.pinkAccent)
                            ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Colors.pinkAccent)
                            )
                        ),
                        onChanged: (data){
                          email=data;
                        },
                      )

                      ,const SizedBox(height: 20,),
                      Obx(()=>
                          TextFormField(
                            validator: (data){
                              if(data!.isEmpty){
                                return "this field is required";
                              }
                            },
                            onChanged: (data){
                              pass=data;
                            },
                            decoration: InputDecoration(hintText: "enter a password",label: Text("password"),
                                border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(15)
                                ),focusedBorder: OutlineInputBorder(borderSide:  const BorderSide(color: Colors.pinkAccent),borderRadius: BorderRadius.circular(15))
                                ,suffixIcon: IconButton(onPressed: (){
                                  taskController.passVisible();

                                }, icon:Icon( taskController.isVisible.value?Icons.visibility_off:Icons.visibility)
                                )
                            ),
                            obscureText: taskController.isVisible.value,

                          ),
                      ),
                      const SizedBox(height: 30,),

                      ElevatedButton(
                        onPressed: ()async{
                        if(formKey.currentState!.validate()){
                          try{
                            await auth.signUp(email: email!, password: pass!);

                            Get.snackbar("note", "success register!");
                            Get.to(LoginPage());
                          }
                          on FirebaseAuthException catch (e) {
                            AuthStatus status;
                            switch (e.code) {

                              case "invalid-email":
                                status = AuthStatus.invalidEmail;
                                Get.snackbar("note", "{$status}");

                                break;
                              case "wrong-password":
                                status = AuthStatus.wrongPassword;
                                Get.snackbar("note", "{$status}");
                                break;
                              case "weak-password":
                                status = AuthStatus.weakPassword;
                                Get.snackbar("note", "{$status}");
                                break;
                              case "email-already-in-use":
                                status = AuthStatus.emailAlreadyExists;
                                Get.snackbar("note", "{$status}");
                                break;
                              default:
                                status = AuthStatus.unknown;
                                Get.snackbar("note", "{$status}");
                            }
                          }
                          catch (e) {
                            print(e);
                          }

                        }
                      }

                        , child: const Text("Sign up"),style:
                        const ButtonStyle(
                          backgroundColor:
                        MaterialStatePropertyAll(Colors.pink),
                        ),
                      ),


                      const SizedBox(height: 10,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("already have an account ? ",
                            style: TextStyle(fontSize: 20),),
                          GestureDetector(onTap: () {
                            Get.to(LoginPage());
                          },
                              child: const Text("Login ", style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,)))
                          ,
                        ],)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
  }
}