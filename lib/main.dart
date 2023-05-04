import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';

import './pages/chat_page.dart';
import './constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const ChatPage(),
    );
  }
}
