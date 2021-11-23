import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Description/components/body.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen(
      {Key? key, required this.item, required this.loggedUser})
      : super(key: key);

  final Item item;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: 'Description',
        item: item,
        loggedUser: loggedUser,
      ),
    );
  }
}
