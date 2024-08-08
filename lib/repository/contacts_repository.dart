import 'package:hive/hive.dart';

class ContactsRepository {
  final Box _contactsBox = Hive.box('contactsBox');

  Future<void> saveContact(String key, Map<String, dynamic> contact) async {
    await _contactsBox.put(key, contact);
  }

  Map<String, dynamic>? getContact(String key) {
    return _contactsBox.get(key) as Map<String, dynamic>?;
  }

  List<Map<dynamic, dynamic>> getAllContacts() {
    return _contactsBox.values.cast<Map<dynamic, dynamic>>().toList();
  }

  Future<void> deleteContact(String key) async {
    await _contactsBox.delete(key);
  }
}
