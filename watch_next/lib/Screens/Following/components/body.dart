import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Following/following_screen.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Following"),
        ),
        body: FutureBuilder<Widget>(
            future: getFollowing(widget.loggedUser),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Text("waiting");
              }
            }));
  }
}

Future<Widget> getFollowing(User loggedUser) async {
  List<User> users = await WatchNextDatabase.findFollowing(loggedUser.id);

  return Scaffold(
    body: PageView(children: [
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {},
              child: Row(children: [
                Flexible(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(users[index].imagePath),
                    ),
                    title: Center(
                      child: Text(users[index].name),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.person_off_rounded,
                    color: Colors.pink,
                    size: 24.0,
                  ),
                  label: const Text('Unfollow'),
                  onPressed: () {
                    WatchNextDatabase.removeFollowing(5, users[index].id);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FollowingScreen(loggedUser: loggedUser)));
                  },
                )
              ]),
            );
          })
    ]),
  );
}
