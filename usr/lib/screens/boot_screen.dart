import 'package:flutter/material.dart';
import 'dart:async';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> with SingleTickerProviderStateMixin {
  final List<String> _systemLogs = [];
  bool _showTitle = false;
  bool _showCreator = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup pulsing animation for the glowing effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _runBootSequence();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _runBootSequence() async {
    // Simulate system boot logs
    await Future.delayed(const Duration(milliseconds: 500));
    _addLog("> Initializing AI Core...");
    
    await Future.delayed(const Duration(milliseconds: 800));
    _addLog("> Loading Neural Network...");
    
    await Future.delayed(const Duration(milliseconds: 800));
    _addLog("> Calibrating WALEK_AI Subsystems...");
    
    await Future.delayed(const Duration(milliseconds: 800));
    _addLog("> Establishing Cognitive Pathways...");
    
    await Future.delayed(const Duration(milliseconds: 600));
    _addLog("> System Online.");

    // Show main title
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _showTitle = true;
      });
    }

    // Show creator text
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() {
        _showCreator = true;
      });
    }

    // Transition to main app
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/chat');
    }
  }

  void _addLog(String log) {
    if (mounted) {
      setState(() {
        _systemLogs.add(log);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Terminal Logs
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: _systemLogs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _systemLogs[index],
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 14,
                          fontFamily: 'Courier',
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Center Branding
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: _showTitle ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: FadeTransition(
                        opacity: _pulseAnimation,
                        child: Text(
                          'KAWALE_AI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            letterSpacing: 4,
                            shadows: [
                              Shadow(
                                color: Colors.cyanAccent.withOpacity(0.8),
                                blurRadius: 15,
                              ),
                              Shadow(
                                color: Colors.blue.withOpacity(0.5),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _showCreator ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        'Created by Pratap Vijay Kawale',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom spacing
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
