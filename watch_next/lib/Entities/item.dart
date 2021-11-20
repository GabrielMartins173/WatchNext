class Item {
  int id;
  String name;
  String description;

  Item(this.id, this.name, this.description);

  Item.fromJson(Map<dynamic, dynamic> json)
      : id = json['ID'],
        name = json['NAME'],
        description = json['DESCRIPTION'];
}