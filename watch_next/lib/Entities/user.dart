class User {
  final int id;
  late final String name;
  late final String email;
  late final String password;

  User(this.id, this.name, this.email, this.password);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['ID'],
        name = json['NAME'],
        email = json['EMAIL'],
        password = json['PASSWORD'];
}