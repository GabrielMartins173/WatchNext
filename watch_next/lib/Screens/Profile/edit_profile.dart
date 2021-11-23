import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Widgets/button_widget.dart';
import 'package:watch_next/database.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key, required this.title, required this.loggedUser}) : super(key: key);

  final String title;
  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    String name = loggedUser.name;
    String email = loggedUser.email;
    String password = loggedUser.password;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            backgroundColor: Colors.blue,
            minRadius: 80.0,
            child: CircleAvatar(
              radius: 70.0,
              backgroundImage:
                  AssetImage(loggedUser.imagePath),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: loggedUser.name,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: loggedUser.email,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: loggedUser.password,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Save',
                  onClicked: () async {
                    await WatchNextDatabase.updateUser(
                        loggedUser, name, email, password);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}
