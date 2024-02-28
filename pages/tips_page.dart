import 'package:billbuddy/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var coffeeProvider = Provider.of<CoffeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakšiš'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Trenutni bakšiš:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${coffeeProvider.tips} RSD',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Expanded(child: Icon(Icons.monetization_on)),
          ],
        ),
      ),
    );
  }
}
