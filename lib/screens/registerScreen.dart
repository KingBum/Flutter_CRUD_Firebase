import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  login() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPassword.text
      );
      DMethod.printTitle("register", credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'Email-already-in-use') {}
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
            Text("Register", style: TextStyle(
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
                child: ElevatedButton(onPressed: () => login(), child: const Text("Register")))
          ],
        ),
      ),
    );
  }
}
