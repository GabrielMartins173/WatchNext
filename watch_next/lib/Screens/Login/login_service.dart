import 'package:watch_next/database.dart';
import 'package:watch_next/Entities/user.dart';

class LoginService {

  static Future<bool> signIn(String email, String password) async {
    try {
      var test = await WatchNextDatabase.findUserByEmailAndPassword(email, password);
    } catch(e) {
      return false;
    }
    return true;
  }

  static Future<void> signUp(String name, String email, String password, String imagePath) async {
    WatchNextDatabase.addUser(
        User(await WatchNextDatabase.getNextUserId(), name, email, password, imagePath));
  }
}