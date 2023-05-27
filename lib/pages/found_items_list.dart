import 'package:flutter/cupertino.dart';

class MyFoundItemListPage extends StatefulWidget {
  const MyFoundItemListPage({super.key, required this.title});

  final String title;

  @override
  State<MyFoundItemListPage> createState() => _MyFoundItemListPage();
}

class _MyFoundItemListPage extends State<MyFoundItemListPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("FOUND ITEM LIST PAGE");
    // TODO: implement build
    throw UnimplementedError();
  }
}
