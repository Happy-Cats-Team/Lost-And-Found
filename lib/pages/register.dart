import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key, required this.title});

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPage();
}

class _MyRegisterPage extends State<MyRegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  // final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              filled: true,
              hintText: 'ivan@email.com',
              labelText: 'Email',
            ),
          ), //Title
          const SizedBox(
            height: 16,
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            maxLines: 1,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              filled: true,
              labelText: 'Password',
            ),
          ), //Description
          const SizedBox(
            height: 16,
          ),
          TextField(
            obscureText: true,
            controller: repeatPasswordController,
            maxLines: 1,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              filled: true,
              labelText: 'Repeat password',
            ),
          ), //
          Container(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                var password = passwordController.text;
                var repeatPassword = repeatPasswordController.text;
                if (password == repeatPassword) {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You successfully registered')));
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    if (error == null) return;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('${error}')));
                  });
                  return;
                }
              },
              child: const Text("Register"),
            ),
          )
        ],
      ),
    );
  }
}
