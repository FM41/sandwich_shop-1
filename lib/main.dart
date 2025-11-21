import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 201, 115, 255), // Set background color to purple
        appBar: AppBar(
          title: const Text('Sandwich Counter'),
          backgroundColor: const Color.fromARGB(255, 158, 103, 255), // darker purple for app bar
        ),
        body: const Center(
          child: OrderScreen(),
        ),
      ),
    );
  }
}

// --------------------------
// Interactive Order Screen
// --------------------------
class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;

  void _increment() {
    setState(() {
      if (_quantity < widget.maxQuantity) _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 0) _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderItemDisplay(quantity: _quantity, itemType: 'Footlong'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _increment, child: const Text('Add')),
            const SizedBox(width: 10),
            ElevatedButton(onPressed: _decrement, child: const Text('Remove')),
          ],
        ),
      ],
    );
  }
}

// --------------------------
// Order Item Display
// --------------------------
class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay({
    super.key,
    required this.quantity,
    required this.itemType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 40,
      color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        '$quantity $itemType sandwich(es): ${'🥪' * quantity}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Sandwich Shop'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
