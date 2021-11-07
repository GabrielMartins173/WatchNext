class NotificationApp {
  int id;
  String type;
  String message;

  NotificationApp(this.id, this.type, this.message);

  NotificationApp.fromJson(Map<dynamic, dynamic> json)
      : id = json['ID'],
        type = json['TYPE'],
        message = json['MESSAGE'];
}
