import 'package:flutter/material.dart';


class BestSellerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Best Seller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Image.asset('assets/eher_braclet.png', height: 150)),
            SizedBox(height: 20),
            Text(
              'Best Seller Items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Here are some of our best-selling items. These products are highly rated by our customers and come highly recommended.',
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
