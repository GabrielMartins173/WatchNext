import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:watch_next/Entities/review.dart';
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
    await db.execute("""DROP TABLE IF EXISTS REVIEW""");
    await db.execute("""DROP TABLE IF EXISTS FOLLOWER""");
    await db.execute("""DROP TABLE IF EXISTS FOLLOWING""");
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
        PASSWORD VARCHAR2,
        IMAGE_PATH VARCHAR2
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

    await db.execute("""CREATE TABLE REVIEW (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        USER_ID INTEGER,
        ITEM_ID INTEGER,
        TEXT VARCHAR2,
        FOREIGN KEY(USER_ID) REFERENCES USER(ID),
        FOREIGN KEY(ITEM_ID) REFERENCES ITEM(ID)
        );""");

    await db.execute("""CREATE TABLE FOLLOWER (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        USER_ID INTEGER,
        FOLLOWER_ID INTEGER,
        FOREIGN KEY(USER_ID) REFERENCES USER(ID),
        FOREIGN KEY(FOLLOWER_ID) REFERENCES USER(ID)
        );""");

    await db.execute("""CREATE TABLE FOLLOWING (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        USER_ID INTEGER,
        FOLLOWING_ID INTEGER,
        FOREIGN KEY(USER_ID) REFERENCES USER(ID),
        FOREIGN KEY(FOLLOWING_ID) REFERENCES USER(ID)
        );""");

    await populate();
  }

  static Future<void> recreateDB() async {
    await deleteDB();
    var db = await openDB();
    await createDB(db);
  }

  static Future<void> populate() async {
    await addUser(
        User(1, "Alan", "saxobeat@usgu.com", "1234", "assets/images/Alan.jpg"));
    await addUser(User(2, "Gabriel", "midoriya@usgu.com", "password",
        "assets/images/Gabriel.jpg"));
    await addUser(User(
        3, "Lucas", "pikachu@usgu.com", "senha", "assets/images/Lucas.jpg"));
    await addUser(
        User(4, "Leo", "doge@usgu.com", "alice", "assets/images/doge.jpg"));
    await addUser(
        User(5, "Carlos", "user", "123", "assets/images/carlos.jpg"));
    await addUser(
        User(6, "Smudge", "user2", "1234", "assets/images/smudge.jpg"));
    await addUser(
        User(7, "Terry", "user3", "12345", "assets/images/terry.jpg"));

    await addItem(Item(1, "John Wick",
        "John Wick ?? um lend??rio assassino de aluguel aposentado, lidando com o luto ap??s perder o grande amor de sua vida. Quando um g??ngster invade sua casa, mata seu cachorro e rouba seu carro, ele ?? for??ado a voltar ?? ativa e inicia sua vingan??a."));
    await addItem(Item(2, "Seinfeld",
        "O comediante Jerry Seinfeld, interpretado por ele mesmo, passa pelas mais triviais aventuras cotidianas, como tomar caf?? em uma lanchonete ou alugar filme em uma locadora, ao lado da feminista Elaine (Julia Louis-Dreyfus), do neur??tico George (Jason Alexander) e do vizinho folgado Kramer (George Costanza)."));
    await addItem(Item(3, "Naruto",
        "Naruto ?? um jovem ??rf??o habitante da Vila da Folha que sonha se tornar o quinto Hokage, o maior guerreiro e governante da vila. ... Agora Naruto vai contar com a ajuda dos colegas Sakura e Sasuke e do professor dos tr??s, Kakashi Hatake, para perseguir seu sonho e deter os ninjas que planejam fazer mal ?? sua cidade."));
    await addItem(Item(4, "Takt Op",
        "Atra??dos para a Terra pela m??sica dos humanos, estranhos monstros conhecidos como D2 agora assolam a Terra e a humanidade. Para impedir seu avan??o, a m??sica ?? proibida em todo o mundo. Entretanto, surgem aqueles dispostos a combater os monstros: Musicarts, garotas que manejam a m??sica como arma, usando as grandes ??peras e partituras da hist??ria a seu favor para derrotar os D2s, e os Conductors, que as orientam e guiam. Em 2047, um Conductor chamado Takt e uma Musicart chamada Destiny viajam pelos EUA, tentando reviver a m??sica e aniquilar os D2 restantes."));
    await addItem(Item(5, "Arcane",
        "A trama gira em torno de uma tecnologia m??gica conhecida com hextec que d?? a qualquer pessoa a habilidade de controlar energia m??stica e essa ferramenta acaba causando um desequil??brio entre os reinos."));
    await addItem(Item(6, "Spider Man",
        "Peter Parker est?? em uma viagem de duas semanas pela Europa, ao lado de seus amigos de col??gio, quando ?? surpreendido pela visita de Nick Fury. Convocado para mais uma miss??o heroica, ele precisa enfrentar v??rios vil??es que surgem em cidades-s??mbolo do continente, como Londres, Paris e Veneza, e tamb??m a apari????o do enigm??tico Mysterio."));
    await addItem(Item(7, "Steven Universe",
        "A s??rie segue as aventuras de Steven, um garoto que herdou uma poderosa miss??o e, junto de seus amigos Garnet, Amethyst e Pearl, precisar??o proteger o mundo de certas amea??as. Enquanto Steven tenta descobrir como usar sua heran??a, ele passa seus dias na Beach City se divertindo com seus amigos."));
    await addItem(Item(8, "Red Notice",
        "Um alerta vermelho da Interpol ?? emitido e o agente do FBI John Hartley assume o caso. Durante sua busca, ele se v?? diante de um assalto ousado e ?? for??ado a se aliar ao maior ladr??o de arte da hist??ria, Nolan Booth, para capturar a ladra de arte mais procurada do mundo atualmente, Sarah Black."));
    await addItem(Item(9, "Avatar",
        "Aang ?? um menino de apenas 12 anos que descobre ser o Avatar, grande mestre respons??vel por garantir o equil??brio entre os quatro elementos - ??gua, terra, fogo e ar - e suas respectivas na????es representantes, mantendo o planeta em seguran??a."));
    await addItem(Item(10, "Invincible",
        "Baseada na s??rie hom??nima de quadrinhos criada por Robert Kirkman (The Walking Dead), Invincible acompanha Mark Grayson, um adolescente que tenta levar uma vida comum, exceto por um pequeno detalhe: ele ?? filho do super-her??i mais poderoso da Terra."));

    await addUserItem(1, 1);
    await addUserItem(1, 5);
    await addUserItem(1, 4);
    await addUserItem(1, 2);
    await addUserItem(2, 4);
    await addUserItem(2, 5);
    await addUserItem(2, 6);
    await addUserItem(2, 7);
    await addUserItem(2, 3);
    await addUserItem(3, 1);
    await addUserItem(3, 3);
    await addUserItem(3, 10);

    await addReview(1, 1, "John wick ?? muito brabo n??o tem nem como.");
    await addReview(1, 5, "Pelo amor de deus que obra.");
    await addReview(1, 4, "Uma delicia de anime");
    await addReview(2, 5, "Quero logo a season 2 bom demais!!");
    await addReview(2, 3, "O naruto pode ser um pouco duro as vezes .... ");
    await addReview(2, 4, "Teach me how to play a piano please !!!!!");

    await addNotification(NotificationApp(1, "Review",
        "Congrats! Your review on the movie John Wick 3 was successfully posted."));
    await addNotification(NotificationApp(2, "Review Friend", "foo"));
    await addNotification(
        NotificationApp(3, "Follower", "Hi Alan. You have a new Follower !"));

    await addFollower(1, 2);
    await addFollower(1, 3);
    await addFollower(1, 4);

    await addFollower(2, 1);
    await addFollower(2, 3);
    await addFollower(2, 4);
    await addFollower(2, 5);
    await addFollower(2, 6);
    await addFollower(2, 7);

    await addFollowing(1, 2);
    await addFollowing(1, 3);
    await addFollowing(1, 4);
    await addFollowing(1, 5);
    await addFollowing(1, 6);
    await addFollowing(2, 1);
    await addFollowing(2, 3);
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
      "PASSWORD": user.password,
      "IMAGE_PATH": user.imagePath
    });
  }

  static Future<void> updateUser(
      User userToUpdate, name, email, password) async {
    var db = await openDB();
    var userToUpdateId = userToUpdate.id;
    await db.rawUpdate(
        "UPDATE USER SET NAME = '$name', EMAIL = '$email', PASSWORD = '$password' WHERE ID = '$userToUpdateId'");
  }

  static Future<User> findUserByEmailAndPassword(
      String email, String password) async {
    var db = await openDB();

    List<Map> maps = await db.query("USER",
        columns: [
          "ID",
          "NAME",
          "EMAIL",
          "PASSWORD",
          "IMAGE_PATH",
          "IMAGE_PATH"
        ],
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
        columns: ["ID", "NAME", "EMAIL", "PASSWORD", "IMAGE_PATH"],
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

  static Future<List<User>> findFollowers(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery(
        """SELECT USER.* FROM USER JOIN FOLLOWER ON FOLLOWER.FOLLOWER_ID = USER.ID WHERE USER_ID = $id""");

    var userList = maps.map((e) {
      return User.fromJson(e);
    }).toList();

    if (userList.isEmpty) {
      // throw FileSystemEntityType.notFound;
    }

    return userList;
  }

  static Future<String> countFollowers(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery(
        """SELECT USER.* FROM USER JOIN FOLLOWER ON FOLLOWER.FOLLOWER_ID = USER.ID WHERE USER_ID = $id""");

    var userList = maps.map((e) {
      return User.fromJson(e);
    }).toList();

    if (userList.isEmpty) {
      // throw FileSystemEntityType.notFound;
    }

    return userList.length.toString();
  }

  static Future<List<User>> findFollowing(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery(
        """SELECT USER.* FROM USER JOIN FOLLOWING ON FOLLOWING.FOLLOWING_ID = USER.ID WHERE USER_ID = $id""");

    var userList = maps.map((e) {
      return User.fromJson(e);
    }).toList();

    // if (userList.isEmpty) {
    //   throw FileSystemEntityType.notFound;
    // }

    return userList;
  }

  static Future<String> countFollowing(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery(
        """SELECT USER.* FROM USER JOIN FOLLOWING ON FOLLOWING.FOLLOWING_ID = USER.ID WHERE USER_ID = $id""");

    var userList = maps.map((e) {
      return User.fromJson(e);
    }).toList();

    // if (userList.isEmpty) {
    //   throw FileSystemEntityType.notFound;
    // }

    return userList.length.toString();
  }

  static Future<List<Item>> findItemsByUser(int id) async {
    var db = await openDB();

    List<Map> maps = await db.rawQuery(
        """SELECT ITEM.* FROM ITEM JOIN USER_ITEM ON USER_ITEM.ITEM_ID = ITEM.ID WHERE USER_ID = $id""");

    var itemList = maps.map((element) {
      return Item.fromJson(element);
    }).toList();

    if (itemList.isEmpty) {
      //throw FileSystemEntityType.notFound;
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
    await db.insert("USER_ITEM", {"USER_ID": userId, "ITEM_ID": itemId});
  }

  static Future<void> removeUserItem(userId, itemId) async {
    var db = await openDB();
    await db.delete("USER_ITEM",
        where: "USER_ID = ? and ITEM_ID = ?", whereArgs: [userId, itemId]);
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

  static Future<void> addFollowing(userId, followingId) async {
    var db = await openDB();
    await db
        .insert("FOLLOWING", {"USER_ID": userId, "FOLLOWING_ID": followingId});
  }

  static Future<void> addFollower(userId, followerId) async {
    var db = await openDB();
    await db.insert("FOLLOWER", {"USER_ID": userId, "FOLLOWER_ID": followerId});
  }

  static Future<void> addReview(userId, itemId, review) async {
    var db = await openDB();
    await db.insert(
        "REVIEW", {"USER_ID": userId, "ITEM_ID": itemId, "TEXT": review});
  }

  static Future<void> removeReview(userId, itemId) async {
    var db = await openDB();
    await db.delete("REVIEW",
        where: "USER_ID = ? and ITEM_ID = ?", whereArgs: [userId, itemId]);
  }

  static Future<void> removeFollowing(userId, followingId) async {
    var db = await openDB();
    await db.delete("FOLLOWING",
        where: "USER_ID = ? and FOLLOWING_ID = ?",
        whereArgs: [userId, followingId]);
  }

  static Future<List<Review>> findReviewsByUser(int id) async {
    var db = await openDB();

    List<Map> maps = await db
        .rawQuery("""SELECT REVIEW.* FROM REVIEW WHERE USER_ID = $id""");

    var reviewList = maps.map((element) {
      return Review.fromJson(element);
    }).toList();

    if (reviewList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return reviewList;
  }

  static Future<String> countReviewsByUser(int id) async {
    var db = await openDB();

    List<Map> maps = await db
        .rawQuery("""SELECT REVIEW.* FROM REVIEW WHERE USER_ID = $id""");

    var reviewList = maps.map((element) {
      return Review.fromJson(element);
    }).toList();

    if (reviewList.isEmpty) {
      throw FileSystemEntityType.notFound;
    }

    return reviewList.length.toString();
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

    List<Map> maps = await db.query("USER",
        columns: ["ID", "NAME", "EMAIL", "PASSWORD", "IMAGE_PATH"]);

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
