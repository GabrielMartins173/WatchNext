class User {
  int id;
  String name;
  String password;

  User(this.id, this.name, this.password);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['ID'],
        name = json['NAME'],
        password = json['PASSWORD'];
}