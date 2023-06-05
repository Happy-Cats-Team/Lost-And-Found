import 'package:flutter/material.dart';

class MyLostItemListPage extends StatefulWidget {
  const MyLostItemListPage({super.key, required this.title});

  final String title;

  @override
  State<MyLostItemListPage> createState() => _MyLostItemListPage();
}

class _MyLostItemListPage extends State<MyLostItemListPage> {
  @override
  Widget build(BuildContext context) {
    // return const Text("LOST ITEM LIST PAGE");
    return ListView.builder(
        itemCount: 14,
        itemBuilder: (context, index) {
          return Column(
            children: const [
              ListTile(
                title: Text("Title"),
                subtitle: Text("description"),
                leading: Icon(Icons.account_tree),
              ),
              Divider()
            ],
          );
        });

    // TODO: implement build
  }
}
