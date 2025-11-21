import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// --------------------------
// Main App
// --------------------------
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
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
  String _note = '';
  String _sandwichSize = 'Footlong'; // New state for sandwich size

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 115, 255),
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
        backgroundColor: const Color.fromARGB(255, 158, 103, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown to select sandwich size
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Size:',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _sandwichSize,
                  dropdownColor: Colors.deepPurple,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  items: const [
                    DropdownMenuItem(value: 'Footlong', child: Text('Footlong')),
                    DropdownMenuItem(value: 'Six-inch', child: Text('Six-inch')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _sandwichSize = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Display the order
            OrderItemDisplay(
              quantity: _quantity,
              itemType: _sandwichSize,
              note: _note.isNotEmpty ? _note : null,
            ),
            const SizedBox(height: 20),

            // TextField for custom notes
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add a note (e.g., no onions, extra pickles)',
              ),
              onChanged: (text) {
                setState(() {
                  _note = text;
                });
              },
            ),
            const SizedBox(height: 20),

            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: StyledButton(
                    text: 'Add',
                    icon: Icons.add,
                    onPressed:
                        _quantity < widget.maxQuantity ? _increment : null,
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StyledButton(
                    text: 'Remove',
                    icon: Icons.remove,
                    onPressed: _quantity > 0 ? _decrement : null,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------
// Reusable StyledButton Widget
// --------------------------
class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final IconData? icon;

  const StyledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// --------------------------
// Order Item Display
// --------------------------
class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;
  final String? note;

  const OrderItemDisplay({
    super.key,
    required this.quantity,
    required this.itemType,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '$quantity $itemType sandwich(es): ${'🥪' * quantity}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (note != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Note: $note',
                style: const TextStyle(
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
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
