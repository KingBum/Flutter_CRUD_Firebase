import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/screens/insert_data.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text
      );
      DMethod.printTitle("login", credential.user!.uid);
      Get.to(() => const InsertData());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
      DMethod.printTitle("Firebase Auth Exception", e.code);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 56,
              color: Colors.blue
            ),),
            DView.spaceHeight(),
            DInput(controller: controllerEmail, hint: "Email",),
            DView.spaceHeight(),
            DInput(controller: controllerPassword, hint: "Password",),
            DView.spaceHeight(),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => login(), child: const Text("Login"))),
          ],
        ),
      ),
    );
  }
}
