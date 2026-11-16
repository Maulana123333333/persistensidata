import 'dart:convert';

import 'package:flutter/material.dart';

import './pizza.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo - Dim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'JSON - Dim'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List untuk menampung objek Pizza hasil parsing
  List<Pizza> myPizzas = [];

  // Method untuk membaca JSON dan mengonversinya menjadi List<Pizza>
  Future<List<Pizza>> readJsonFile() async {
    // Membaca file JSON tidak konsisten (Praktikum 2)
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');

    List pizzaMapList = jsonDecode(myString);
    List<Pizza> myPizzas = [];

    for (var pizza in pizzaMapList) {
      Pizza myPizza = Pizza.fromJson(pizza);
      myPizzas.add(myPizza);
    }

    // Mengonversi kembali ke JSON string dan mencetaknya di Debug Console (Slide 12)
    String json = convertToJSON(myPizzas);
    print(json);

    return myPizzas;
  }

  // Method serialisasi List<Pizza> kembali ke JSON String (Slide 12)
  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((pizza) => jsonEncode(pizza)).toList());
  }

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Menampilkan daftar objek Pizza dalam ListView (Slide 11)
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myPizzas[index].pizzaName),
            subtitle: Text(
              '${myPizzas[index].description} - \$${myPizzas[index].price}',
            ),
          );
        },
      ),
    );
  }
}
