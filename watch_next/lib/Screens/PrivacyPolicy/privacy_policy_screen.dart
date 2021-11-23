import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'package:watch_next/Screens/PrivacyPolicy/components/body.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key, required this.loggedUser}) : super(key: key);

  final User loggedUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: "Privacy Policy",
        loggedUser: loggedUser,
      ),
    );
  }
}
