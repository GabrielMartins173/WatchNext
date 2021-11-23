import 'package:flutter/material.dart';
import 'package:watch_next/Entities/user.dart';

import 'package:watch_next/Screens/CreateReview/components/body.dart';

class CreateReviewScreen extends StatelessWidget {
  const CreateReviewScreen({Key? key, required this.loggedUserId, required this.itemId}) : super(key: key);

  final int loggedUserId;
  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        title: "Create Review",
        loggedUserId: loggedUserId,
        itemId: itemId,
      ),
    );
  }
}
