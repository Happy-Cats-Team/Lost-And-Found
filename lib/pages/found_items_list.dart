import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import 'detail_view.dart';

class MyFoundItemListPage extends StatefulWidget {
  const MyFoundItemListPage({super.key, required this.title});

  final String title;

  @override
  State<MyFoundItemListPage> createState() => _MyFoundItemListPage();
}

class _MyFoundItemListPage extends State<MyFoundItemListPage> {
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
                      subtitle: Text(
                        '${posts[index].description}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // context.owner.
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: DetailViewItem(item: posts[index]),
                            appBar: AppBar(title: Text("Detail View")),
                          ),
                        ));
                      },
                      // leading: Image.network(posts[index].image), //Fixme Add
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
        .where("type", isEqualTo: "found")
        .get();
    return data.docs
        .map((docSnapshot) => Item.fromJson(docSnapshot.data()))
        .toList();
  }
}
