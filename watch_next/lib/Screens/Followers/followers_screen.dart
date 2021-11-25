import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Followers/components/body.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(loggedUser: loggedUser),
    );
  }
}
