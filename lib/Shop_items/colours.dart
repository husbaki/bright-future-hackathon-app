import 'package:flutter/material.dart';


class ColoursPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Colours')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.asset('assets/colours.png', height: 150)),
            SizedBox(height: 20),
            Text(
              'Colourful Items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Brighten up your life with our colourful products. From vibrant hues to soft pastels, find the perfect items to match your style.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
