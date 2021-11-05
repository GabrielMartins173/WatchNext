import 'package:sqflite/sqflite.dart';
import 'package:watch_next/user.dart';

import 'item.dart';

class WatchNextDatabase {

  static Future<void> deleteDB() async {
    var db = await openDB();
    await db.execute("""DROP TABLE IF EXISTS ITEM""");
    await db.execute("""DROP TABLE IF EXISTS USER""");
    db.close();
  }

  static Future<void> createDB(Database db) async {
    await db.execute("""CREATE TABLE ITEM (
        ID NUMERIC PRIMARY KEY,
        NAME VARCHAR2,
        DESCRIPTION VARCHAR2
        );""");

    await db.execute("""CREATE TABLE USER (
        ID NUMERIC PRIMARY KEY,
        NAME VARCHAR2,
        PASSWORD VARCHAR2
        );""");

    populate();

  }

  static Future<void> recreateDB() async {
    await deleteDB();
    var db = await openDB();
    await createDB(db);
    db.close();

  }

  static void populate() {
    addUser(User(1, "Alan", "Saxobeat"));
    addUser(User(2, "Gabriel", "Midoriya"));
    addUser(User(3, "Lucas", "Pikachu"));
    addUser(User(4, "Leo", "Doge"));

    addItem(Item(1, "John Wick", "brabes"));
    addItem(Item(2, "Seinfeld", "brabes"));
    addItem(Item(3, "Naruto", "brabes"));
    addItem(Item(4, "Takt.op", "brabes"));

}

  static Future<void> addUser(User user) async {
    var db = await openDB();
    await db.insert("USER", {"ID": user.id, "NAME": user.name, "PASSWORD": user.password});

  }

  static Future<void> addItem(Item item) async {
    var db = await openDB();
    await db.insert("ITEM", {"ID": item.id, "NAME": item.name, "DESCRIPTION": item.description});

  }

  static Future<List<Item>> getItem(int id) async {
    var db = await openDB();

    List<Map> maps = await db.query("ITEM", columns: ["ID", "NAME", "DESCRIPTION"],
        where: "ID = ?",
        whereArgs: [id]);

    var itemList = maps.map((element) {return Item.fromJson(element);}).toList();
    db.close();
    return itemList;
  }

  static Future<List> getAllItem() async {
    var db = await openDB();

    List<Map> maps = await db.query("ITEM", columns: ["ID", "NAME", "DESCRIPTION"]);

    var itemList = maps.map((element) {return Item.fromJson(element);}).toList();

    db.close();
    return itemList;
  }

  static void deleteItem(int id) async {
    var db = await openDB();

    await db.delete("ITEM",
        where: "ID = ?",
        whereArgs: [id]);

    db.close();

  }

  static Future<Database> openDB() async {
    var db = await openDatabase("database", version: 1, onCreate: (Database db, int version) async {createDB(db);});
    return db;
  }

}