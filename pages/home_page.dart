import 'package:billbuddy/data/data.dart';
import 'package:billbuddy/pages/bills_page.dart';
import 'package:billbuddy/pages/tips_page.dart';
import 'package:billbuddy/util/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController tableNumberController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var coffeeProvider = Provider.of<CoffeeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.coffee),
        title: Title(
          child: const Text('BillBuddy 2024'),
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orangeAccent,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: ''),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_currentIndex == 0)
              Column(
                children: [
                  // bill buddy naziv
                  Text(
                    'BillBuddy - na usluzi!',
                    style: GoogleFonts.quicksand(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // polje za unos stolova
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.table_bar),
                        hintText: 'Unesite broj stola',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade500),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade500)),
                      ),
                      controller: tableNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // prikaz pica
                  SizedBox(
                    height: 480,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: coffeeProvider.coffees.length,
                      itemBuilder: (context, index) {
                        var coffee = coffeeProvider.coffees[index];
                        return CoffeeTile(
                          coffee: coffee,
                          tableNumberController: tableNumberController,
                        );
                      },
                    ),
                  ),
                ],
              ),
            if (_currentIndex == 1)
              SizedBox(
                height: double.maxFinite,
                child: BillsPage(),
              ),
            if (_currentIndex == 2)
              SizedBox(height: double.maxFinite, child: TipsPage()),
          ],
        ),
      ),
    );
  }
}
