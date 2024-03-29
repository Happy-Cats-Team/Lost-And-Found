import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/item.dart';

class MyAddItemPage extends StatefulWidget {
  const MyAddItemPage({super.key, required this.title});

  final String title;

  @override
  State<MyAddItemPage> createState() => _MyAddPageItem();
}

class _MyAddPageItem extends State<MyAddItemPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final telegramController = TextEditingController();
  // final descriptionController = TextEditingController();
  String type = "lost";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                filled: true,
                hintText: 'write title here...',
                labelText: 'Title',
              ),
            ), //Title
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                icon: Icon(Icons.comment),
                filled: true,
                hintText: 'write description',
                labelText: 'Description',
              ),
            ), //Description
            const SizedBox(
              height: 16,
            ),
            DropdownButtonFormField(
              value: "lost",
              items: const [
                DropdownMenuItem(value: "lost", child: Text("Lost")),
                DropdownMenuItem(value: "found", child: Text("Found"))
              ],
              onChanged: (value) {
                if (value != null) {
                  type = value;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: phoneController,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                filled: true,
                hintText: '+7 000 000 00 00',
                labelText: 'Phone number',
              ),
            ), //Phone
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: telegramController,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.telegram),
                filled: true,
                hintText: '@telegram',
                labelText: 'Telegram Alias',
              ),
            ), //Telegram
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  addItem(
                      title: titleController.text,
                      description: descriptionController.text,
                      type: type,
                      phone: phoneController.text,
                      telegram: telegramController.text);
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }

  addItem(
      {required String title,
      required String description,
      required String type,
      required String phone,
      String? telegram}) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error unauthorized')));
      return;
    }
    FirebaseFirestore.instance
        .collection("posts")
        .add(Item(
                uid: uid,
                title: title,
                type: type,
                description: description,
                phone: phone,
                telegram: telegram)
            .toJson())
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Post Added')));
    });
  }
}
