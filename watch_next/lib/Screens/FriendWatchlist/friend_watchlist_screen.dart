import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'components/body.dart';

class FriendWatchlistScreen extends StatelessWidget {
  const FriendWatchlistScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: "WatchList - " + loggedUser.name,
        loggedUser: loggedUser,
      ),
    );
  }
}
