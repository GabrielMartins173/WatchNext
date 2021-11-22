import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_next/Components/rounded_input_field.dart';
import 'package:watch_next/Components/text_field_container.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Screens/Profile/profile_page.dart';
import 'package:watch_next/Widgets/button_widget.dart';
import 'package:watch_next/Widgets/numbers_widget.dart';
import 'package:watch_next/database.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    String name = widget.loggedUser.name;
    String email = widget.loggedUser.email;
    String password = widget.loggedUser.password;

    List inputs = [];

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          CircleAvatar(
            backgroundColor: Colors.blue,
            minRadius: 80.0,
            child: CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage(
                  'assets/images/' + widget.loggedUser.name + '.jpg'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: email,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: password,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 24),
                buildSaveButton(widget.loggedUser, name, email, password)
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

  Widget buildSaveButton(User loggedUser, name, email, password) =>
      ButtonWidget(
        text: 'Save',
        onClicked: () {
          print("valor nome " + name);
          print("valor email  " + email);
          print("valor password " + password);
          WatchNextDatabase.updateUser(loggedUser, name, email, password);
        },
      );
}
