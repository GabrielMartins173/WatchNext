import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
/*import 'package:watch_next/Screens/Notifications/notification_screen.dart';
import 'package:watch_next/Screens/Notifications/notification_service.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/database.dart';*/

class Body extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Body({Key? key, required this.title, required this.item});

  // This Widgets is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App Widgets) and
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
      body: SingleChildScrollView(
          child:
      Container(
      padding: const EdgeInsets.all(8),

      child: Column(children: [
        ElevatedButton(onPressed: () {}, child: const Text("Add to Watchlist")),
        ElevatedButton(onPressed: () {}, child: const Text("Write a review")),
        Container(
          child: Image(
              image: AssetImage('assets/images/' + item.name + '_poster.jpg')),
          margin: const EdgeInsets.all(20),
          height: 300,
        ),
        Text(item.name, textScaleFactor: 3),
        Container(
          child: Column(
            children: [
              const Text("Synopsis:",
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Sans Serif')),
              Text(item.description)
            ], crossAxisAlignment: CrossAxisAlignment.start,
          ),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF00309A),
                  Color(0xFF000E28),
                ],
              )),
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
        )
      ]),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          )),
    ),
    )
    ,
    );
  }
}
