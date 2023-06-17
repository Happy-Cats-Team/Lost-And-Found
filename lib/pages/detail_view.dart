import 'package:flutter/material.dart';

import '../models/item.dart';

class DetailViewItem extends StatefulWidget {
  const DetailViewItem({super.key, required this.item});

  final Item item;

  @override
  State<DetailViewItem> createState() => _DetailViewItem();
}

class _DetailViewItem extends State<DetailViewItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.item.title}',
              style: TextStyle(fontSize: 32),
            ),
            const SizedBox(
              height: 16,
            ),
            Text('${widget.item.description}', style: TextStyle(fontSize: 16)),
            const SizedBox(
              height: 16,
            ),
            Text(capitalize('${widget.item.type}')),
            const SizedBox(
              height: 16,
            ),
            Text('${widget.item.phone}'),
            const SizedBox(
              height: 16,
            ),
            Text('${widget.item.telegram}')
          ],
        ),
      ),
    );
    // widget.title
    // TODO: implement build
    throw UnimplementedError();
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
