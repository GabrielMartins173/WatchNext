import 'package:flutter/material.dart';
import 'package:watch_next/Screens/Home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(
        title: 'WatchNext',
      ),
    );
  }
}
