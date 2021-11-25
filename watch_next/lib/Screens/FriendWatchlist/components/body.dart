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
  State<Body> createState() => _WatchList();
}

class _WatchList extends State<Body> {
  List<Widget> watchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
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

    var watchList = itemList
        .map((item) => Card(
              key: ValueKey(item),
              child: ListTile(
                  title: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DescriptionScreen(item: item, loggedUser: widget.loggedUser)),
                      );
                    },
                    child: ClipRRect(child: Row(children: [
                    SizedBox(
                      child: Image.asset(
                          'assets/images/' + item.name + '_logo.png'),
                      width: 100,
                    ),
                    Text(item.name),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xC4DE0000)),
                        child: const Text("Like"))
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween))),
                  leading: const Icon(CupertinoIcons.line_horizontal_3)),
              color: const Color(0xA41C1C1C),
              semanticContainer: true,
              shadowColor: const Color(0xD8F63434),
              elevation: 15,
            ))
        .toList();

    return ReorderableListView(
        children: watchList,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = watchList.removeAt(oldIndex);
            watchList.insert(newIndex, item);
          });
        });
  }
}
