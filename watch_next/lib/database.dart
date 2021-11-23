import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:watch_next/Entities/user.dart';
import 'package:watch_next/Entities/user_item.dart';

import 'Entities/item.dart';
import 'package:watch_next/Entities/notification.dart';

class WatchNextDatabase {
  static Future<void> deleteDB() async {
    var db = await openDB();
    await db.execute("""DROP TABLE IF EXISTS ITEM""");
    await db.execute("""DROP TABLE IF EXISTS USER""");
    await db.execute("""DROP TABLE IF EXISTS NOTIFICATION""");
    await db.execute("""DROP TABLE IF EXISTS USER_ITEM""");
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

    await db.execute("""CREATE TABLE USER_ITEM (
        USER_ID INTEGER,
        ITEM_ID INTEGER,
        PRIMARY KEY(USER_ID, ITEM_ID),
        FOREIGN KEY(USER_ID) REFERENCES USER(ID),
        FOREIGN KEY(ITEM_ID) REFERENCES ITEM(ID)
        );""");

    await populate();
  }

  static Future<void> recreateDB() async {
    await deleteDB();
    var db = await openDB();
    await createDB(db);
  }

  static Future<void> populate() async {
    await addUser(User(1, "Alan", "saxobeat@usgu.com", "1234"));
    await addUser(User(2, "Gabriel", "midoriya@usgu.com", "password"));
    await addUser(User(3, "Lucas", "pikachu@usgu.com", "senha"));
    await addUser(User(4, "Leo", "doge@usgu.com", "alice"));
    await addUser(User(5, "user", "user", "123"));

    await addItem(Item(1, "John Wick", "John Wick é um lendário assassino de aluguel aposentado, lidando com o luto após perder o grande amor de sua vida. Quando um gângster invade sua casa, mata seu cachorro e rouba seu carro, ele é forçado a voltar à ativa e inicia sua vingança."));
    await addItem(Item(2, "Seinfeld", "O comediante Jerry Seinfeld, interpretado por ele mesmo, passa pelas mais triviais aventuras cotidianas, como tomar café em uma lanchonete ou alugar filme em uma locadora, ao lado da feminista Elaine (Julia Louis-Dreyfus), do neurótico George (Jason Alexander) e do vizinho folgado Kramer (George Costanza)."));
    await addItem(Item(3, "Naruto", "Naruto é um jovem órfão habitante da Vila da Folha que sonha se tornar o quinto Hokage, o maior guerreiro e governante da vila. ... Agora Naruto vai contar com a ajuda dos colegas Sakura e Sasuke e do professor dos três, Kakashi Hatake, para perseguir seu sonho e deter os ninjas que planejam fazer mal á sua cidade."));
    await addItem(Item(4, "Takt Op", "Atraídos para a Terra pela música dos humanos, estranhos monstros conhecidos como D2 agora assolam a Terra e a humanidade. Para impedir seu avanço, a música é proibida em todo o mundo. Entretanto, surgem aqueles dispostos a combater os monstros: Musicarts, garotas que manejam a música como arma, usando as grandes óperas e partituras da história a seu favor para derrotar os D2s, e os Conductors, que as orientam e guiam. Em 2047, um Conductor chamado Takt e uma Musicart chamada Destiny viajam pelos EUA, tentando reviver a música e aniquilar os D2 restantes."));
    await addItem(Item(5, "Arcane", "A trama gira em torno de uma tecnologia mágica conhecida com hextec que dá a qualquer pessoa a habilidade de controlar energia mística e essa ferramenta acaba causando um desequilíbrio entre os reinos."));
    await addItem(Item(6, "Spider Man", "Peter Parker está em uma viagem de duas semanas pela Europa, ao lado de seus amigos de colégio, quando é surpreendido pela visita de Nick Fury. Convocado para mais uma missão heroica, ele precisa enfrentar vários vilões que surgem em cidades-símbolo do continente, como Londres, Paris e Veneza, e também a aparição do enigmático Mysterio."));
    await addItem(Item(7, "Steven Universe", "A série segue as aventuras de Steven, um garoto que herdou uma poderosa missão e, junto de seus amigos Garnet, Amethyst e Pearl, precisarão proteger o mundo de certas ameaças. Enquanto Steven tenta descobrir como usar sua herança, ele passa seus dias na Beach City se divertindo com seus amigos."));
    await addItem(Item(8, "Red Notice", "Um alerta vermelho da Interpol é emitido e o agente do FBI John Hartley assume o caso. Durante sua busca, ele se vê diante de um assalto ousado e é forçado a se aliar ao maior ladrão de arte da história, Nolan Booth, para capturar a ladra de arte mais procurada do mundo atualmente, Sarah Black."));
    await addItem(Item(9, "Avatar", "Aang é um menino de apenas 12 anos que descobre ser o Avatar, grande mestre responsável por garantir o equilíbrio entre os quatro elementos - água, terra, fogo e ar - e suas respectivas nações representantes, mantendo o planeta em segurança."));
    await addItem(Item(10, "Invincible", "Baseada na série homônima de quadrinhos criada por Robert Kirkman (The Walking Dead), Invincible acompanha Mark Grayson, um adolescente que tenta levar uma vida comum, exceto por um pequeno detalhe: ele é filho do super-herói mais poderoso da Terra."));

    await addUserItem(1, 1);
    await addUserItem(1, 5);
    await addUserItem(1, 4);
    await addUserItem(1, 2);
    await addUserItem(2, 4);
    await addUserItem(2, 5);
    await addUserItem(2, 6);
    await addUserItem(2, 7);
    await addUserItem(2, 3);


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

    return currentId;
  }

  static Future<int> getNextItemId() async {
    var db = await openDB();
    int currentId =
        Sqflite.firstIntValue(await db.rawQuery('SELECT MAX(ID) FROM ITEM'))!;

    return currentId;
  }

  static Future<void> addUser(User user) async {
    var db = await openDB();
    await db.insert("USER", {
      "NAME": user.name,
      "EMAIL": user.email,
      "PASSWORD": user.password
    });
  }

  static Future<void> updateUser(User userToUpdate, name, email, password) async {
    var db = await openDB();
    print("valor nome " + name);
    print("valor email  " + email);
    print("valor password " + userToUpdate.id.toString());
    var userToUpdateId = userToUpdate.id;
    await db.rawUpdate("UPDATE USER SET NAME = '$name', EMAIL = '$email', PASSWORD = '$password' WHERE ID = '$userToUpdateId'");
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

    if (userList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return userList.first;
  }

  static Future<User> findUserById(int id) async {
    var db = await openDB();

    List<Map> maps = await db.query("USER",
        columns: ["ID", "NAME", "EMAIL", "PASSWORD"],
        where: "ID = ?",
        whereArgs: [id]);

    var userList = maps.map((element) {
      return User.fromJson(element);
    }).toList();

    if (userList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return userList.first;
  }

  static Future<List<Item>> findItemsByUser(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery("""SELECT ITEM.* FROM ITEM JOIN USER_ITEM ON USER_ITEM.ITEM_ID = ITEM.ID WHERE USER_ID = $id""");

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();

    if (itemList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return itemList;
  }

  static Future<void> addItem(Item item) async {
    var db = await openDB();
    await db.insert("ITEM",
        {"ID": item.id, "NAME": item.name, "DESCRIPTION": item.description});
  }

  static Future<void> addUserItem(userId, itemId) async {
    var db = await openDB();
    await db.insert("USER_ITEM",
        {"USER_ID": userId, "ITEM_ID": itemId});
  }

  static Future<void> removeUserItem(userId, itemId) async {
    var db = await openDB();
    await db.delete("USER_ITEM",
        where:"USER_ID = ? and ITEM_ID = ?", whereArgs: [userId, itemId]);
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
    return itemList.first;
  }

  static Future<List> getAllNotifications() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("NOTIFICATION", columns: ["ID", "TYPE", "MESSAGE"]);

    var itemList = maps.map((element) {
      return NotificationApp.fromJson(element);
    }).toList();

    return itemList;
  }

  static Future<List> getAllItems() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("ITEM", columns: ["ID", "NAME", "DESCRIPTION"]);

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();

    return itemList;
  }

  static Future<List> getAllUsers() async {
    var db = await openDB();

    List<Map> maps =
        await db.query("USER", columns: ["ID", "NAME", "EMAIL", "PASSWORD"]);

    var userList = maps.map((element) {
      return User.fromJson(element);
    }).toList();

    return userList;
  }

  static void deleteItem(int id) async {
    var db = await openDB();

    await db.delete("ITEM", where: "ID = ?", whereArgs: [id]);

  }
}
