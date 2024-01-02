    import 'package:flutter/material.dart';
    import 'cart.dart';
    import 'package:http/http.dart' as http;
    const String _baseURL = 'achenial-armfuls.000webhostapp.com';

    class CartPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Shopping Cart'),
    centerTitle: true,
    ),
    body: Column(
    children: [
    Expanded(
    child: ListView.builder(
    itemCount: shoppingCart.items.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(shoppingCart.items[index].toyname),
    subtitle: Text('\$${shoppingCart.items[index].toyprice.toStringAsFixed(2)}'),
    );
    },
    ),
    ),
    Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton(
    onPressed: () async {
    // Extract toy IDs from the shopping cart
    List<int> toyIds = shoppingCart.items.map((toy) => toy.toyID).toList();

    // Call the server-side script to create the order
    final response = await http.post(
    Uri.https(_baseURL, 'createOrder.php'),
    body: {'toy_ids': toyIds.join(',')}, // Assuming the server expects a comma-separated list of toy IDs
    );

    if (response.statusCode == 200) {
    // Order successfully created
    shoppingCart.items.clear(); // Clear the shopping cart
    Navigator.of(context).pop(); // Close the order details dialog

    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text('Order Placed'),
    content: Text('Your order has been placed successfully.'),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text('OK'),
    ),
    ],
    );
    },
    );
    } else {
    // Handle errors, e.g., display an error message
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text('Error'),
    content: Text('Failed to place the order. Please try again.'),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text('OK'),
    ),
    ],
    );
    },
    );
    }
    },
    child: Text('Proceed to Order'),
    ),
    ),
    ],
    ),
    );
    }
    }