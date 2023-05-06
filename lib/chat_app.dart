import 'package:flutter/material.dart';

import './constants/themes.dart';
import './pages/chat_page.dart';
import './pages/login_page.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        ChatPage.routeName: (context) => const ChatPage(),
        LoginPage.routeName: (context) => const LoginPage(),
      },
    );
  }
}
