import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Description/description_screen.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.title, required this.loggedUser})
      : super(key: key);

  // This Widgets is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App Widgets) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final User loggedUser;

  @override
  State<Body> createState() => _PrivacyPolicy();
}

class _PrivacyPolicy extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
            title: Text(widget.title)),
        body: PageView(
          children: [
            FutureBuilder<Widget>(
                future: getPrivacyPolicy(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const Text("waiting");
                  }
                }),
          ],
        ));
  }

  Future<Widget> getPrivacyPolicy() async {
    return SizedBox(
        height: 50,
        child: Card(
        child: Image.asset(
        'assets/images/privacyPolicy.png',
    ),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: const EdgeInsets.all(10),
    ));
  }
}
