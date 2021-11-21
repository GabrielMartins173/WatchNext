import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'components/body.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        user: user,
      ),
    );
  }
}
