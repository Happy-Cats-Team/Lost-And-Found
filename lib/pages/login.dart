import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/item.dart';
import 'package:lost_and_found/pages/register.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text)
                  .then((value) {});
            },
            child: const Text("Login"),
          ),
          const Text("Not having and account?"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: const MyRegisterPage(
                    title: 'Register',
                  ),
                  appBar: AppBar(title: const Text("Register")),
                ),
              ));
            },
            child: const Text("Register"),
          )
        ],
      ),
    );
  }

  addItem(
      {required String title,
      required String description,
      required String phone,
      String? telegram}) async {
    print(title);
    print(description);
    print(phone);
    print(FirebaseAuth.instance.currentUser?.uid);
    return;
    FirebaseFirestore.instance.collection("posts").add(Item(
            title: title,
            description: description,
            phone: phone,
            telegram: telegram)
        .toJson());
    //     .onError((error, stackTrace) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Error ${error}')));
    // }).then((value) {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(const SnackBar(content: Text('Post added')));
    // });
  }

  Future<List<Item>> getItems() async {
    var data = await FirebaseFirestore.instance
        .collection("posts")
        .where("type", isEqualTo: "lost")
        .get();
    return data.docs
        .map((docSnapshot) => Item.fromJson(docSnapshot.data()))
        .toList();
  }
}
