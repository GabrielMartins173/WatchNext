import 'package:sqflite/sqflite.dart';

import 'Screens/Home/components/item.dart';

class WatchNextDatabase {
  static Future<void> createDB(Database db) async {
    //await db.execute("""DROP TABLE ITEM""");

    await db.execute("""CREATE TABLE ITEM (
        ID NUMERIC PRIMARY KEY,
        NAME VARCHAR2,
        DESCRIPTION VARCHAR2
        );""");

    populate(db);
  }

  static void populate(Database db) {
    addItemBatch(Item(1, "Alan", "Saxobeat"), db);
    addItemBatch(Item(2, "Gabriel", "Midoriya"), db);
    addItemBatch(Item(3, "Lucas", "Pikachu"), db);
    addItemBatch(Item(4, "Leo", "Doge"), db);
  }

  static Future<void> addItemBatch(Item item, Database db) async {
    await db.insert("ITEM",
        {"ID": item.id, "NAME": item.name, "DESCRIPTION": item.description});
  }

  static Future<void> addItem(Item item) async {
    var db = await openDB();
    await db.insert("ITEM",
        {"ID": item.id, "NAME": item.name, "DESCRIPTION": item.description});
  }

  static Future<List<Item>> getItem(int id) async {
    var db = await openDB();

    List<Map> maps = await db.query("ITEM",
        columns: ["ID", "NAME", "DESCRIPTION"],
        where: "ID = ?",
        whereArgs: [id]);

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();
    db.close();
    return itemList;
  }

  static Future<List> getAllItem() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("ITEM", columns: ["ID", "NAME", "DESCRIPTION"]);

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();

    db.close();
    return itemList;
  }

  static void deleteItem(int id) async {
    var db = await openDB();

    await db.delete("ITEM", where: "ID = ?", whereArgs: [id]);

    db.close();
  }

  static Future<Database> openDB() async {
    var db = await openDatabase("database", version: 1,
        onCreate: (Database db, int version) async {
      createDB(db);
    });
    return db;
  }
}
