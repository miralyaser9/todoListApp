import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolistfirsbase1/views/login.dart';
import 'package:todolistfirsbase1/widgets/button.dart';
import 'package:todolistfirsbase1/widgets/custom_textfield.dart';

import '../helpers/auth.dart';

class ResetPass extends StatefulWidget {
   ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
   AuthenticationHelper auth = AuthenticationHelper();

 String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You can reset your password ,please write your email!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blueAccent),),
            const SizedBox(height: 80,),

            CustomTextField(hintText: "enter your email", label: "email"
              ,oncahnged: (value){
              email=value;

              },
            ),
            const SizedBox(height: 20,),
            Button(
              buttonName: "Reset",
              ontabb: () async {

                  await auth.resetPassword(email: email!);
                  Get.snackbar("note", "we sent an email verfication to you");
                  Get.to(LoginPage());

              },
            )
          ],
        ),
      )
    );
  }
}
