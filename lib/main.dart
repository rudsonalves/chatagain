import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';

import './pages/chat_page.dart';
import './themes/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        // colorSchemeSeed: Colors.amber,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          // backgroundColor: lightColorScheme.,
          // foregroundColor: lightColorScheme.inverseSurface,
        ),
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          // backgroundColor: darkColorScheme.primary,
          // foregroundColor: darkColorScheme.onPrimary,
        ),
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      home: const ChatPage(),
    );
  }
}
