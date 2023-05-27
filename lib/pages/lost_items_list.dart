import 'package:flutter/cupertino.dart';

class MyLostItemListPage extends StatefulWidget {
  const MyLostItemListPage({super.key, required this.title});

  final String title;

  @override
  State<MyLostItemListPage> createState() => _MyLostItemListPage();
}

class _MyLostItemListPage extends State<MyLostItemListPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("LOST ITEM LIST PAGE");
    // TODO: implement build
    throw UnimplementedError();
  }
}
