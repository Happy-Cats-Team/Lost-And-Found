import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String? title;
  final String? description;
  final String? where;
  final String? phone;
  final String? telegram;

  Item({this.title, this.description, this.where, this.phone, this.telegram});

  factory Item.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Item(
        title: data?['title'],
        description: data?['description'],
        where: data?['where'],
        phone: data?['phone'],
        telegram: data?['telegram']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (where != null) "where": where,
      if (phone != null) "phone": phone,
      if (telegram != null) "telegram": telegram,
    };
  }
}
