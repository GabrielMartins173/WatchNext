import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'components/body.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        loggedUser: loggedUser,
      ),
    );
  }
}
