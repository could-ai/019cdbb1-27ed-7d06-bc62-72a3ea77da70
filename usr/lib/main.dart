import 'package:flutter/material.dart';
import 'screens/boot_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const KawaleAiApp());
}

class KawaleAiApp extends StatelessWidget {
  const KawaleAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KAWALE_AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.amber,
          surface: Color(0xFF1E1E1E),
        ),
        // Using a monospace font to give it a robotic/terminal feel
        fontFamily: 'Courier', 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Courier',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.cyanAccent,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BootScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
