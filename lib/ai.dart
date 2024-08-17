import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIChatPage extends StatefulWidget {
  @override
  _AiChatPageState createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AIChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'role': 'user', 'content': message});
    });

    final response = await http.post(
      Uri.parse('http://192.168.1.146:8081/chat'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'message': message}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      setState(() {
        _messages.add({'role': 'assistant', 'content': responseBody['response']});
      });
    } else {
      // Handle error
      print('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255), // Purple with transparency
              Color.fromARGB(255, 205, 177, 255), // Light purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message['role'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: message['role'] == 'user' ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['content']!,
                        style: TextStyle(color: Colors.white, fontFamily: 'Consolas'),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final message = _controller.text;
                      _controller.clear();
                      _sendMessage(message);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
