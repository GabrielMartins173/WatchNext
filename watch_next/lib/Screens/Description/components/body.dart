import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Screens/Notifications/notification_screen.dart';
import 'package:watch_next/Screens/Notifications/notification_service.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/database.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.title, required this.item});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Item item;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: PageView(
        children: [
          getCard(),
        ],
      ),
    );
  }

  Widget getCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Text(item.name),
        Expanded(
          child: Image(
              image: AssetImage('assets/images/' + item.name + '_poster.jpg')),
        ),
        Text(item.description)
      ]),
      color: Colors.teal[600],
    );
  }
}
