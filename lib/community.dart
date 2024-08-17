import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'SharedPreferences.dart'; // Импортируйте файл SharedPreferences.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: CommunityPage(),
    );
  }
}

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late Future<List<Post>> futurePosts;
  bool isCreatingPost = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  String fullName = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    Map<String, String?> userDetails = await UserPreferences.getUserDetails();
    setState(() {
      fullName = userDetails['fullName'] ?? 'No Name';
      username = userDetails['username'] ?? 'No Username';
    });
  }

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('http://192.168.1.146:8081/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> createPost(Post newPost) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.146:8081/posts'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newPost.toJson()),
    );

    if (response.statusCode == 201) {
      setState(() {
        futurePosts = fetchPosts();
        isCreatingPost = false;
        _titleController.clear();
        _contentController.clear();
      });
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255), // Фиолетовый с прозрачностью
              Color.fromARGB(255, 205, 177, 255), // Светло-фиолетовый
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
          ProfileHeader(
          fullName: 'No Name',
          username: 'No Username',
        ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCreatingPost = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Замените primary на backgroundColor
                  foregroundColor: Colors.white, // Замените onPrimary на foregroundColor
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Make a post'),
              ),
            ),
            if (isCreatingPost)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          labelText: 'Content',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            DateTime now = DateTime.now();
                            String formattedDate = DateFormat('MM/dd/yyyy').format(now);
                            final newPost = Post(
                              title: _titleController.text,
                              username: '@$username',
                              date: formattedDate,
                              content: _contentController.text,
                            );
                            createPost(newPost);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple, // Замените primary на backgroundColor
                          foregroundColor: Colors.white, // Замените onPrimary на foregroundColor
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Publish'),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load posts'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return PostCard(post: snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String fullName;
  final String username;

  ProfileHeader({required this.fullName, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/профиль.png'),
            radius: 40.0,
            backgroundColor: Colors.transparent,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Consolas',
              ),
            ),
            Text(
              '@$username',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
                fontFamily: 'Consolas',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6161D4),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${post.username} • ${post.date}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              post.content,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String username;
  final String date;
  final String content;

  Post({
    required this.title,
    required this.username,
    required this.date,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      username: json['username'],
      date: json['date'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'username': username,
      'date': date,
      'content': content,
    };
  }
}
