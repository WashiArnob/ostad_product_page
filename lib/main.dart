import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingBagApp());
}

class ShoppingBagApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Bag',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyBagPage(),
    );
  }
}

class MyBagPage extends StatefulWidget {
  @override
  _MyBagPageState createState() => _MyBagPageState();
}

class _MyBagPageState extends State<MyBagPage> {

  List<int> quantities = [1, 1, 1];


  List<double> unitPrices = [51.0, 30.0, 43.0];


  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < quantities.length; i++) {
      total += quantities[i] * unitPrices[i];
    }
    return total;
  }

  // Function to calculate total price for individual product
  double calculateProductTotal(int index) {
    return quantities[index] * unitPrices[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Column(
        children: [
          // Pullover Item
          buildCartItem('Pullover', 'Black', 'L', unitPrices[0], 0),
          Divider(),
          // T-Shirt Item
          buildCartItem('T-Shirt', 'Gray', 'M', unitPrices[1], 1),
          Divider(),
          // Sport Dress Item
          buildCartItem('Sport Dress', 'Black', 'M', unitPrices[2], 2),
          Divider(),

          // Total Amount Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total amount:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${calculateTotal().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Check Out Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background color
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Checkout successful! Congratulations!')),
              );
            },
            child: Text('CHECK OUT'),
          ),
        ],
      ),
    );
  }


  Widget buildCartItem(String name, String color, String size, double price, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Image Placeholder
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[300],
            child: Icon(Icons.shopping_bag, size: 50),
          ),

          SizedBox(width: 10),

          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Color: $color   Size: $size'),
                Text('\$$price each', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Quantity Controls
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (quantities[index] > 1) quantities[index]--;
                      });
                    },
                  ),
                  Text(
                    '${quantities[index]}',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        quantities[index]++;
                      });
                    },
                  ),
                ],
              ),


              Text(
                '\$${calculateProductTotal(index).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
