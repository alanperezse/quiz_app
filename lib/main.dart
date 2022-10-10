import 'package:flutter/cupertino.dart';
import 'package:quiz_app/views/homepage.dart';
import 'views/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemPink
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}
