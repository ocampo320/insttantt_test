import 'package:flutter/material.dart';
import 'package:insttantt_test/repository/contacts_repository.dart';

class ContactsProvider with ChangeNotifier {
  final ContactsRepository _contactsRepository = ContactsRepository();

  List<Map<dynamic, dynamic>> _contacts = [];

  List<Map<dynamic, dynamic>> get contacts => _contacts;

  Future<void> loadContacts() async {
    _contacts = _contactsRepository.getAllContacts();
    notifyListeners();
  }

  Future<void> addContact(String name, String document) async {
    final key = name;
    final contact = {
      'name': name,
      'document': document,
    };
    await _contactsRepository.saveContact(key, contact);
    await loadContacts();
  }

  Future<void> deleteContact(String name) async {
    final key = name;
    await _contactsRepository.deleteContact(key);
    await loadContacts();
  }

  void searchContacts(String query) {
    if (query.length > 2) {
      _contacts = _contacts
          .where((contact) =>
              contact['name'].toLowerCase().contains(query.toLowerCase()) ||
              contact['document'].contains(query))
          .toList();
    } else {
      loadContacts();
    }
    notifyListeners();
  }
}
