import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GamePage(),
  ));
}

// Главная страница игры
class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 0
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255),
              Color.fromARGB(255, 205, 177, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Text(
                    "Star SAT Academic",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.star, color: Colors.orange),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GameCard(
                        imagePath: 'assets/reading_world.png',
                        title: 'Reading World',
                        description: 'Learn and play a game about reading',
                        imageOnRight: false,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReadingQuizPage()),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GameCard(
                        imagePath: 'assets/writing_land.png',
                        title: 'Writing Land',
                        description: 'Learn and play a game about writing',
                        imageOnRight: true,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WritingQuizPage()),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GameCard(
                        imagePath: 'assets/math_world.png',
                        title: 'Mathematicstan',
                        description: 'Learn and play a game about math',
                        imageOnRight: false,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MathQuizPage()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            RankingWidget(), // Добавляем блок с рейтингом
          ],
        ),
      )
          : SizedBox.shrink(), // Не отображать ничего, если ширина экрана меньше или равна нулю
    );
  }
}

// Виджет карточки игры
class GameCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool imageOnRight;
  final VoidCallback onPressed;

  GameCard({
    required this.imagePath,
    required this.title,
    required this.description,
    this.imageOnRight = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!imageOnRight)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath,
                      height: 120, width: 120, fit: BoxFit.cover),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("PLAY"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (imageOnRight)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(imagePath,
                      height: 120, width: 120, fit: BoxFit.cover),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Страница с тестом по чтению
class ReadingQuizPage extends StatefulWidget {
  @override
  _ReadingQuizPageState createState() => _ReadingQuizPageState();
}

class _ReadingQuizPageState extends State<ReadingQuizPage> {
  int _score = 0;
  int _currentQuestionIndex = 0;

  final List<String> _questions = [
    'What is the main theme of the story?',
    'What does the character feel in the end?',
  ];
  final List<List<String>> _options = [
    ['Adventure', 'Romance', 'Sci-Fi'],
    ['Happy', 'Sad', 'Angry'],
  ];
  final List<int> _correctAnswers = [0, 1];

  void _answerQuestion(int index) {
    if (index == _correctAnswers[_currentQuestionIndex]) {
      setState(() {
        _score += 1;
      });
    }
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex += 1;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
                score: _score, totalQuestions: _questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 0
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255),
              Color.fromARGB(255, 205, 177, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _questions[_currentQuestionIndex],
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ..._options[_currentQuestionIndex]
                  .asMap()
                  .entries
                  .map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(entry.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(entry.value),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      )
          : SizedBox.shrink(),
    );
  }
}

// Страница с тестом по письму
class WritingQuizPage extends StatefulWidget {
  @override
  _WritingQuizPageState createState() => _WritingQuizPageState();
}

class _WritingQuizPageState extends State<WritingQuizPage> {
  int _score = 0;
  int _currentQuestionIndex = 0;

  final List<String> _questions = [
    'What is the main purpose of the essay?',
    'Which writing style is used?',
  ];
  final List<List<String>> _options = [
    ['Informative', 'Persuasive', 'Narrative'],
    ['APA', 'MLA', 'Chicago'],
  ];
  final List<int> _correctAnswers = [0, 1];

  void _answerQuestion(int index) {
    if (index == _correctAnswers[_currentQuestionIndex]) {
      setState(() {
        _score += 1;
      });
    }
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex += 1;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
                score: _score, totalQuestions: _questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 0
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255),
              Color.fromARGB(255, 205, 177, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _questions[_currentQuestionIndex],
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ..._options[_currentQuestionIndex]
                  .asMap()
                  .entries
                  .map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(entry.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(entry.value),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      )
          : SizedBox.shrink(),
    );
  }
}

// Страница с тестом по математике
class MathQuizPage extends StatefulWidget {
  @override
  _MathQuizPageState createState() => _MathQuizPageState();
}

class _MathQuizPageState extends State<MathQuizPage> {
  int _score = 0;
  int _currentQuestionIndex = 0;

  final List<String> _questions = [
    'Solve the equation: 2x + 3 = 11',
    'What is the value of π (pi)?',
  ];
  final List<List<String>> _options = [
    ['x = 4', 'x = 5', 'x = 6'],
    ['3.14', '3.15', '3.16'],
  ];
  final List<int> _correctAnswers = [1, 0];

  void _answerQuestion(int index) {
    if (index == _correctAnswers[_currentQuestionIndex]) {
      setState(() {
        _score += 1;
      });
    }
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex += 1;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
                score: _score, totalQuestions: _questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).size.width > 0
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(150, 51, 0, 255),
              Color.fromARGB(255, 205, 177, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _questions[_currentQuestionIndex],
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ..._options[_currentQuestionIndex]
                  .asMap()
                  .entries
                  .map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () => _answerQuestion(entry.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(entry.value),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      )
          : SizedBox.shrink(),
    );
  }
}

// Виджет для отображения результатов теста
class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            const SizedBox(height: 20),
            Text(
              'You scored $score out of $totalQuestions',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: Text('Back to Game'),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет блока с рейтингом
class RankingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.purple,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'Rank 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Наджмудин',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Rank 2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Аслан',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'Rank 3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Жангир',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
