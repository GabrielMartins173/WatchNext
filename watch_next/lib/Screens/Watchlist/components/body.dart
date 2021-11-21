import 'package:flutter/material.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/Entities/user.dart';

class Body extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Body({required this.loggedUser});

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        Text(loggedUser.name)
      ],
    ));
  }
}
