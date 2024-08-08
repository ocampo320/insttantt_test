import 'package:hive/hive.dart';
import 'package:insttantt_test/models/user.dart';

class UserRepository {
  final Box _userBox = Hive.box('userBox');

  Future<void> saveUser(User user) async {
    await _userBox.put(user.email, user.toJson());
  }

  Future<String?> getPassword(String username) async {
    final userMap = _userBox.get(username) ;
    return userMap?['password'];
  }

  Future<User?> getAll(String username) async {
    final userMap = _userBox.get(username);
    return User.fromJson(userMap);
  }

  Future<bool> login(String username, String password) async {
    final storedPassword = await getPassword(username);
    return storedPassword == password;
  }

  Future<void> deleteUser(String username) async {
    await _userBox.delete(username);
  }
}
