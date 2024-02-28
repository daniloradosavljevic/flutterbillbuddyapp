import 'package:billbuddy/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final TextEditingController tableNumberController;

  const CoffeeTile(
      {Key? key, required this.coffee, required this.tableNumberController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var coffeeProvider = Provider.of<CoffeeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black45,
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                'lib/images/${coffee.image}',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              coffee.name,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              '${coffee.price} RSD',
              style: const TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: IconButton(
                onPressed: () {
                  if (tableNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Unesite broj stola!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    var tableNumber =
                        int.tryParse(tableNumberController.text) ?? 0;
                    coffeeProvider.addCoffeeToBill(tableNumber, coffee);
                  }
                },
                icon: const Icon(Icons.add_circle),
                iconSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
