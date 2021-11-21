import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(title: 'WatchNext', loggedUser: loggedUser),
    );
  }
}
