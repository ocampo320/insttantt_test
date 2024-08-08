import 'package:flutter/material.dart';
import 'package:insttantt_test/modules/contacts/provider/contacts_provider.dart';
import 'package:insttantt_test/modules/contacts/provider/views/add_contact_view.dart';
import 'package:provider/provider.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    final contactsProvider = Provider.of<ContactsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis contactos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => contactsProvider.searchContacts(query),
              decoration: const InputDecoration(
                labelText: 'Buscar contacto',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ContactsProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = provider.contacts[index];
                    return ListTile(
                      title: Text(contact['name']),
                      subtitle: Text(contact['document']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.deleteContact(contact['name']);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactScreen()),
          );
        },
        tooltip: 'Agregar contacto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
