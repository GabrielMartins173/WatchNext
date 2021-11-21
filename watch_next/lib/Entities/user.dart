class User {
  final int id;
  final String name;
  final String email;
  final String password;

  User(this.id, this.name, this.email, this.password);

  User.fromJson(Map<dynamic, dynamic> json)
      : id = json['ID'],
        name = json['NAME'],
        email = json['EMAIL'],
        password = json['PASSWORD'];
}