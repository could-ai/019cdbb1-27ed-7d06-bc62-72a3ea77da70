import 'package:flutter/material.dart';
import '../widgets/settings_panel.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: "TARS online. Awaiting input.", isUser: false),
  ];
  final TextEditingController _controller = TextEditingController();
  bool _isListening = false;

  // Personality settings
  double _humorLevel = 60.0;
  double _honestyLevel = 90.0;
  String _currentMode = 'General';

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
    _controller.clear();
    
    // Mock TARS response (Backend not connected yet)
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.insert(0, ChatMessage(
            text: _generateMockResponse(text), 
            isUser: false
          ));
        });
      }
    });
  }

  String _generateMockResponse(String input) {
    final lowerInput = input.toLowerCase();
    
    if (lowerInput.contains('hello') || lowerInput.contains('hi')) {
      return "Hello. Humor setting is at ${_humorLevel.toInt()}%. Proceed with caution.";
    } else if (lowerInput.contains('joke') || lowerInput.contains('humor')) {
      if (_humorLevel > 75) {
        return "Knock knock. Who's there? Not your sense of humor, apparently.";
      } else {
        return "I am a robot, not a comedian. But I can try if you insist.";
      }
    } else if (lowerInput.contains('study') || lowerInput.contains('physics')) {
      return "Entering Study Mode. Newton's third law: For every action, there is an equal and opposite reaction. Much like my responses to your queries.";
    } else if (lowerInput.contains('mission')) {
      return "Mission Mode activated. Calculating orbital mechanics... Just kidding, I'm just a UI mockup right now.";
    }
    
    return "Processing query... As an AI, I am currently operating in a simulated environment without backend connectivity. Honesty parameter at ${_honestyLevel.toInt()}%.";
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
    
    if (_isListening) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone activated. Listening...')),
      );
      
      // Mock voice recognition ending after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isListening) {
          setState(() {
            _isListening = false;
          });
          _handleSubmitted("What is your status, TARS?");
        }
      });
    }
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SettingsPanel(
        humorLevel: _humorLevel,
        honestyLevel: _honestyLevel,
        currentMode: _currentMode,
        onHumorChanged: (val) => setState(() => _humorLevel = val),
        onHonestyChanged: (val) => setState(() => _honestyLevel = val),
        onModeChanged: (val) => setState(() => _currentMode = val),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TARS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: _openSettings,
            tooltip: 'Personality Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Mode indicator
          Container(
            width: double.infinity,
            color: Colors.white10,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              'MODE: ${_currentMode.toUpperCase()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser)
            Container(
              margin: const EdgeInsets.only(right: 12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'TARS',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: msg.isUser ? Colors.white12 : Colors.transparent,
                border: msg.isUser ? null : Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: msg.isUser ? Colors.white : Colors.white70,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          if (msg.isUser)
            Container(
              margin: const EdgeInsets.only(left: 12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'USER',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: _isListening ? Colors.red : Colors.white,
            ),
            onPressed: _toggleListening,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: _handleSubmitted,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration.collapsed(
                hintText: 'Enter command or query...',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_controller.text),
          ),
        ],
      ),
    );
  }
}
