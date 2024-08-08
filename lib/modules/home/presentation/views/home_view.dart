import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insttantt_test/modules/contacts/provider/contacts_provider.dart';
import 'package:insttantt_test/modules/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final contactsProvider = Provider.of<ContactsProvider>(context);
    final userName = authProvider.userName;
    final email = authProvider.email;
    final userImage = authProvider.userImage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hola, $userName'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: userImage != null
                  ? FileImage(userImage)
                  : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile != null) {
                  await authProvider.updateUserImage(pickedFile.path, email);
                }
              },
              child: const Text('Agregar o Editar Imagen'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user');
              },
              child: const Text('Inicio'),
            ),
            TextButton(
              onPressed: () {
                contactsProvider.loadContacts();
                Navigator.pushNamed(context, '/contacts');
              },
              child: const Text('Contactos'),
            ),
          ],
        ),
      ),
    );
  }
}
