import 'package:flutter/material.dart';
import 'package:watch_next/Entities/item.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/Entities/user.dart';
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
  State<Body> createState() => _WatchList();
}

class _WatchList extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        FutureBuilder<Widget>(
            future: getCards(),
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

  Future<Widget> getCards() async {
    List<Item> itemList =
        await WatchNextDatabase.findItemsByUser(widget.loggedUser.id);

    var containerList = itemList
        .map((item) => Container(
              padding: const EdgeInsets.all(8),
              child: Card(child:
              Row(children: [
                Container(
                  child:
                      Image.asset('assets/images/' + item.name + '_logo.png'),
                  width: 100,
                ),
                Text(item.name),
                ElevatedButton(onPressed: () {WatchNextDatabase.removeUserItem(widget.loggedUser.id, item.id); setState(() {});}, child: const Text("delete"))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
                color: const Color(0xA41C1C1C),
                semanticContainer: true,
                shadowColor: const Color(0xD8F63434),
                elevation: 15,
            )))
        .toList();

    return Column(children: containerList);
  }
}
