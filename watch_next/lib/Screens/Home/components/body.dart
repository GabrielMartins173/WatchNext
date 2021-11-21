import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Description/description_screen.dart';
import 'package:watch_next/Screens/Notifications/notification_screen.dart';
import 'package:watch_next/Screens/Notifications/notification_service.dart';
import 'package:watch_next/Entities/notification.dart';
import 'package:watch_next/Screens/Profile/profile_page.dart';
import 'package:watch_next/Screens/Watchlist/watchlist_screen.dart';
import '../../../Entities/item.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.title, required this.loggedUser}) : super(key: key);

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
  State<Body> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Body> {
  int _counter = 0;
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _incrementCounter() async {
    WatchNextDatabase.addItem(Item(_counter + 5, "test", "test"));
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn);
  }

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
        title: Text(widget.title + '    bem vindo ' + widget.loggedUser.name),
      ),
      body: PageView(
        controller: pageController,
        children: [
          FutureBuilder<Widget>(
              future: getCardList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Text("waiting");
                }
              }),
          WatchlistScreen(user: widget.loggedUser),
          FutureBuilder<Widget>(
            future: builderNotifications(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("waiting");
              }
            },
          ),
          FutureBuilder<Widget>(
            future: profilePage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("waiting");
              }
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'WatchList'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
    );
  }

  Future<Widget> builderNotifications() async {
    List<NotificationApp> notList =
        (await NotificationService.getNotifications()).cast<NotificationApp>();

    return NotificationScreen(
      listNot: notList,
    ).build(context);
  }

  Future<Widget> getCardList() async {
    List<Item> itemList = (await WatchNextDatabase.getAllItems()).cast<Item>();

    var containerList = itemList
        .map((item) => Container(
              padding: const EdgeInsets.all(8),
              child: Column(children: [
                Text(item.name),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionScreen(item: item)),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child:
                        Image.asset('assets/images/' + item.name + '_logo.png'),
                  ),
                )),
                ElevatedButton(
                    onPressed: () {
                      WatchNextDatabase.deleteItem(item.id);
                      setState(() {
                        _counter++;
                      });
                    },
                    child: const Text("delete"))
              ]),
              color: Colors.teal[600],
            ))
        .toList();

    var grid = GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: containerList);
    return grid;
  }

  Future<Widget> profilePage() async{
    return const ProfilePage();
  }
}
