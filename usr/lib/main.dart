import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const TarsApp());
}

class TarsApp extends StatelessWidget {
  const TarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TARS AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
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
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ChatScreen(),
      },
    );
  }
}
