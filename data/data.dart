import 'package:flutter/foundation.dart';

class Coffee {
  final String name;
  final String image;
  final double price;

  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

class Bill {
  final int tableNumber;
  final List<Coffee> orderedCoffees;
  double totalPrice;

  Bill({
    required this.tableNumber,
    required this.orderedCoffees,
    required this.totalPrice,
  });
}

class CoffeeProvider extends ChangeNotifier {
  List<Coffee> coffees = [
    Coffee(name: 'Latte', image: 'latte.jpg', price: 220),
    Coffee(name: 'Cappuccino', image: 'cappucino.jpg', price: 180),
    Coffee(name: 'Espresso', image: 'espreso.jpg', price: 150),
    Coffee(name: 'Americano', image: 'americano.jpg', price: 250),
    Coffee(name: 'Mocha', image: 'mocha.jpg', price: 300),
    Coffee(name: 'Turkish', image: 'turkish.jpg', price: 200),
  ];
  List<Bill> bills = [];
  double tips = 0;
  void addCoffeeToBill(int tableNumber, Coffee coffee) {
    var bill = bills.firstWhere(
      (bill) => bill.tableNumber == tableNumber,
      orElse: () {
        var newBill =
            Bill(tableNumber: tableNumber, orderedCoffees: [], totalPrice: 0);
        bills.add(newBill);
        return newBill;
      },
    );

    bill.orderedCoffees.add(coffee);

    bill.totalPrice += coffee.price;

    notifyListeners();
  }

  void removeCoffeeFromBill(int tableNumber, Coffee coffee) {
    var bill = bills.firstWhere(
      (bill) => bill.tableNumber == tableNumber,
      orElse: () =>
          Bill(tableNumber: tableNumber, orderedCoffees: [], totalPrice: 0),
    );

    bill.orderedCoffees.remove(coffee);
    bill.totalPrice -= coffee.price;

    notifyListeners();
  }

  static void addTips(double amount, CoffeeProvider coffeeProvider) {
    coffeeProvider.tips += amount;
    coffeeProvider.notifyListeners();
  }

  void removeBill(Bill bill) {
    bills.remove(bill);
    notifyListeners();
  }
}
