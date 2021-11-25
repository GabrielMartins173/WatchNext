import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/database.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Followers"),
        ),
        body: FutureBuilder<Widget>(
            future: getFollowers(widget.loggedUser),
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

Future<Widget> getFollowers(User loggedUser) async {
  List<User> users = await WatchNextDatabase.findFollowers(loggedUser.id);
  return Scaffold(
    body: PageView(children: [
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {},
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(users[index].imagePath),
                ),
                title: Center(
                  child: Text(users[index].name),
                ),
              ),
            );
          })
    ]),
  );
}
