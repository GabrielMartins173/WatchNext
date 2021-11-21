import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:watch_next/Entities/user.dart';

import 'Entities/item.dart';
import 'package:watch_next/Entities/notification.dart';

class WatchNextDatabase {
  static Future<void> deleteDB() async {
    var db = await openDB();
    await db.execute("""DROP TABLE IF EXISTS ITEM""");
    await db.execute("""DROP TABLE IF EXISTS USER""");
    await db.execute("""DROP TABLE IF EXISTS NOTIFICATION""");
    db.close();
  }

  static Future<void> createDB(Database db) async {
    await db.execute("""CREATE TABLE ITEM (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME VARCHAR2,
        DESCRIPTION VARCHAR2
        );""");

    await db.execute("""CREATE TABLE USER (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        NAME VARCHAR2,
        EMAIL VARCHAR2,
        PASSWORD VARCHAR2
        );""");

    await db.execute("""CREATE TABLE NOTIFICATION (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TYPE VARCHAR2,
        MESSAGE VARCHAR2
        );""");

    await populate();
  }

  static Future<void> recreateDB() async {
    await deleteDB();
    var db = await openDB();
    await createDB(db);
    db.close();
  }

  static Future<void> populate() async {
    await addUser(User(1, "Alan", "Saxobeat@usgu.com", "1234"));
    await addUser(User(2, "Gabriel", "Midoriya@usgu.com", "password"));
    await addUser(User(3, "Lucas", "Pikachu@usgu.com", "data de aniversario"));
    await addUser(User(4, "Leo", "Doge@usgu.com", "alice"));
    await addUser(User(5, "user", "user", "123"));

    await addItem(Item(1, "John Wick", "brabes"));
    await addItem(Item(2, "Seinfeld", "brabes"));
    await addItem(Item(3, "Naruto", "brabes"));
    await addItem(Item(4, "Takt Op", "brabes"));

    await addNotification(NotificationApp(1, "Review",
        "Congrats! Your review on the movie John Wick 3 was successfully posted."));
    await addNotification(NotificationApp(2, "Review Friend", "foo"));
    await addNotification(
        NotificationApp(3, "Follower", "Hi Alan. You have a new Follower !"));
  }

  static Future<Database> openDB() async {
    var db = await openDatabase("database", version: 1,
        onCreate: (Database db, int version) async {
      createDB(db);
    });
    return db;
  }

  static Future<int> getNextUserId() async {
    var db = await openDB();
    int currentId =
        Sqflite.firstIntValue(await db.rawQuery('SELECT MAX(ID) FROM USER'))!;
    db.close();

    return currentId;
  }

  static Future<int> getNextItemId() async {
    var db = await openDB();
    int currentId =
        Sqflite.firstIntValue(await db.rawQuery('SELECT MAX(ID) FROM ITEM'))!;
    db.close();

    return currentId;
  }

  static Future<void> addUser(User user) async {
    var db = await openDB();
    await db.insert("USER",
        {"NAME": user.name, "EMAIL": user.email, "PASSWORD": user.password});
    db.close();
  }

  static Future<User> findUserByEmailAndPassword(
      String email, String password) async {
    var db = await openDB();

    List<Map> maps = await db.query("USER",
        columns: ["ID", "NAME", "EMAIL", "PASSWORD"],
        where: "EMAIL = ? AND PASSWORD = ?",
        whereArgs: [email, password]);

    var userList = maps.map((element) {
      return User.fromJson(element);
    }).toList();
    db.close();

    if (userList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return userList.first;
  }

  static Future<void> addItem(Item item) async {
    var db = await openDB();
    await db.insert("ITEM",
        {"ID": item.id, "NAME": item.name, "DESCRIPTION": item.description});
  }

  static Future<Item> findItemById(int id) async {
    var db = await openDB();

    List<Map> maps = await db.query("ITEM",
        columns: ["ID", "NAME", "DESCRIPTION"],
        where: "ID = ?",
        whereArgs: [id]);

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();
    db.close();
    return itemList.first;
  }

  static Future<void> addNotification(NotificationApp not) async {
    var db = await openDB();
    await db.insert("NOTIFICATION",
        {"ID": not.id, "TYPE": not.type, "MESSAGE": not.message});
  }

  static Future<NotificationApp> findNotificationById(int id) async {
    var db = await openDB();

    List<Map> maps = await db.query("NOTIFICATION",
        columns: ["ID", "TYPE", "MESSAGE"], where: "ID = ?", whereArgs: [id]);

    var itemList = maps.map((element) {
      return NotificationApp.fromJson(element);
    }).toList();
    db.close();
    return itemList.first;
  }

  static Future<List> getAllNotifications() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("NOTIFICATION", columns: ["ID", "TYPE", "MESSAGE"]);

    var itemList = maps.map((element) {
      return NotificationApp.fromJson(element);
    }).toList();

    db.close();
    return itemList;
  }

  static Future<List> getAllItems() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("ITEM", columns: ["ID", "NAME", "DESCRIPTION"]);

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();

    db.close();
    return itemList;
  }

  static Future<List> getAllUsers() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("USER", columns: ["ID", "NAME", "EMAIL", "PASSWORD"]);

    var userList = maps.map((element) {
      return User.fromJson(element);
    }).toList();
    //userList.forEach((element) {print(element.name);});
    db.close();
    return userList;
  }

  static void deleteItem(int id) async {
    var db = await openDB();

    await db.delete("ITEM", where: "ID = ?", whereArgs: [id]);

    db.close();
  }
}
