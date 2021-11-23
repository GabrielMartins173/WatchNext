import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'package:watch_next/Screens/Reviews/components/body.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: "Reviews",
        loggedUser: loggedUser,
      ),
    );
  }
}
