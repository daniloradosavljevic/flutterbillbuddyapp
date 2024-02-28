import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:billbuddy/data/data.dart';

class BillsPage extends StatelessWidget {
  void _payBill(
      BuildContext context, CoffeeProvider coffeeProvider, Bill bill) {
    coffeeProvider.removeBill(bill);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Račun je plaćen!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  final TextEditingController tipsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var coffeeProvider = Provider.of<CoffeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Računi'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(15),
          child: PageView.builder(
            itemCount: coffeeProvider.bills.length,
            itemBuilder: (context, index) {
              var bill = coffeeProvider.bills[index];
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                child: ListTile(
                  title: Row(
                    children: [
                      const Icon(
                        Icons.table_bar,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Sto broj: ${bill.tableNumber}',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Pića:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      for (var coffee in bill.orderedCoffees)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '- ${coffee.name}, ${coffee.price} RSD',
                              style: const TextStyle(fontSize: 18),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                coffeeProvider.removeCoffeeFromBill(
                                    bill.tableNumber, coffee);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      Text(
                        'Totalno: ${bill.totalPrice} RSD',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: tipsController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.monetization_on),
                          hintText: 'Unesite sumu',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500)),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          double uneseno = double.parse(tipsController.text);
                          _payBill(context, coffeeProvider, bill);
                          CoffeeProvider.addTips(
                              uneseno - bill.totalPrice, coffeeProvider);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.payments_outlined,
                              size: 30,
                            ),
                            Text(
                              "Plati",
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
