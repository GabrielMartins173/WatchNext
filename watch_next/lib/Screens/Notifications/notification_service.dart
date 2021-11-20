import 'package:watch_next/Entities/notification.dart';

import 'package:watch_next/database.dart';

class NotificationService {
  static Future<List<NotificationApp>> getNotifications() async {
    List<NotificationApp> itemList =
        (await WatchNextDatabase.getAllNotifications()).cast<NotificationApp>();
    return itemList;
  }
}
