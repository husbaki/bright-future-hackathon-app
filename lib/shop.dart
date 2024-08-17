import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Импортируйте url_launcher

class ShopPage extends StatelessWidget {
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ProfileHeader(
                      fullName: 'No Name',
                      username: 'No Username',
                    ),
                    const SizedBox(height: 20),
                    NewsItem(
                      imagePath: 'assets/ielts_webinar.png',
                      title: 'Как набрать 8.0 в IELTS Speaking',
                      overview:
                      'Как сдать IELTS на высокий балл? Результат не заставит себя ждать, если вы начнёте подготовку вместе с Quickstarter.',
                      url: 'https://www.youtube.com/watch?v=_s1rIKaoAyM',
                    ),
                    const SizedBox(height: 10),
                    NewsItem(
                      imagePath: 'assets/sat_course.png',
                      title: 'Как набрать 1400+ по SAT за 3 месяца?',
                      overview:
                      'Хочешь сдать SAT, но не уверен в своей подготовке? Мы покажем, как получить 1400+ за 2-3 месяца.',
                      url: 'https://www.youtube.com/watch?v=Xsw8QSgAP3k&list=PLXmJvdMwHZJ-UdQx7Y79LluJpYblQK9yV',
                    ),
                    // Другие новости по аналогии
                  ],
                ),
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

class NewsItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String overview;
  final String url;

  NewsItem({
    required this.imagePath,
    required this.title,
    required this.overview,
    required this.url,
  });

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Consolas',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      overview,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        fontFamily: 'Consolas',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
