import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HelpersPage extends StatefulWidget {
  @override
  _HelpersPageState createState() => _HelpersPageState();
}

class _HelpersPageState extends State<HelpersPage> {
  List<String> helpers = [];
  final TextEditingController _controller = TextEditingController();
  final String serverUrl = 'http://192.168.1.146:8081/send/emergency';

  @override
  void initState() {
    super.initState();
    _loadHelpers();
  }

  Future<void> _loadHelpers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      helpers = prefs.getStringList('helpers') ?? [];
    });
  }

  Future<void> _addHelper(String helper) async {
    if (helper.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      helpers.add(helper);
      await prefs.setStringList('helpers', helpers);
      setState(() {});
      _controller.clear();
    }
  }

  Future<void> _removeHelper(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    helpers.removeAt(index);
    await prefs.setStringList('helpers', helpers);
    setState(() {});
  }

  Future<void> _sendEmergency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? chatIds = prefs.getStringList('helpers');
    if (chatIds == null || chatIds.isEmpty) {
      return;
    }

    final response = await http.post(
      Uri.parse(serverUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(chatIds.map((id) => int.parse(id)).toList()),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Emergency message sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send emergency message.')),
      );
    }
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Helpers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter a number',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addHelper(_controller.text),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: helpers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(helpers[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeHelper(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _sendEmergency,
              child: Text('Send Emergency Message'),
            ),
          ],
        ),
      ),
    );
  }
}
