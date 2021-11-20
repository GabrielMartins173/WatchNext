import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Screens/Description/components/body.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: 'Description',
        item: item
      ),
    );
  }
}
