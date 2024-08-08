import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:insttantt_test/modules/contacts/provider/contacts_provider.dart';
import 'package:insttantt_test/modules/contacts/provider/views/contacts_view.dart';
import 'package:insttantt_test/modules/home/presentation/views/home_view.dart';
import 'package:insttantt_test/modules/login/presentation/views/login_view.dart';
import 'package:insttantt_test/modules/login/provider/login_provider.dart';
import 'package:insttantt_test/modules/register/presentation/views/resgitration_view.dart';
import 'package:insttantt_test/modules/register/register_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('contactsBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => ContactsProvider()),
      ],
      child: const InsttanttApp(),
    ),
  );
}

class InsttanttApp extends StatelessWidget {
  const InsttanttApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginView(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(builder: (context) => LoginView());
          case '/register':
            return MaterialPageRoute(builder: (context) => RegisterView());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomeView());
          case '/contacts':
            return MaterialPageRoute(
                builder: (context) => const ContactsView());
          default:
            return MaterialPageRoute(builder: (context) => const HomeView());
        }
      },
      /*  onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      }, */
    );
  }
}
