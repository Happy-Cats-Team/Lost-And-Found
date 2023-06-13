import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/models/item.dart';

class MyLostItemListPage extends StatefulWidget {
  const MyLostItemListPage({super.key, required this.title});

  final String title;

  @override
  State<MyLostItemListPage> createState() => _MyLostItemListPage();
}

class _MyLostItemListPage extends State<MyLostItemListPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          var posts = snapshot.data ?? [];
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text('${posts[index].title}'),
                      subtitle: Text('${posts[index].description}'),
                      // leading: Image.network(posts[index].image),
                    ),
                    const Divider()
                  ],
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        );
      },
    );
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
