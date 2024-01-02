import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'achenial-armfuls.000webhostapp.com';

class Toys {
  String _imagePath;
  int _toyID;
  String _toyname;
  String _toycategory;
  String _ageGroup;
  String _manufacturer;
  double _toyprice;
  bool _inStock;
  String _releaseDate;
  String _description;

  Toys(
      this._imagePath,
      this._toyID,
      this._toyname,
      this._toycategory,
      this._ageGroup,
      this._manufacturer,
      this._toyprice,
      this._inStock,
      this._releaseDate,
      this._description,
      );

  String get imagePath => _imagePath;

  int get toyID => _toyID;

  @override
  String toString() {
    return '\n'
        'Toy ID: ${_toyID.toString()}\n'
        'Toy Name: $_toyname\n'
        'Category: $_toycategory\n'
        'Age Group: $_ageGroup\n'
        'Manufacturer: $_manufacturer\n'
        'Toy Price: $_toyprice\n'
        'In Stock: ${_inStock ? 'Yes' : 'No'}\n'
        'Release Date: $_releaseDate\n'
        'Description: $_description\n';
  }

  String get toyname => _toyname;

  double get toyprice => _toyprice;
}

List<Toys> _toys = [];

Future<void> updateProducts(update) async {
  try {
    final url = Uri.https(_baseURL, 'getToys.php');
    final response = await http.get(url).timeout(const Duration(seconds: 20));

    _toys.clear();

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);

      for (var row in jsonResponse) {
        Toys t = Toys(
          row['image_path'],
          int.parse(row['toy_id']),
          row['toy_name'],
          row['category'],
          row['age_group'],
          row['manufacturer'],
          double.parse(row['price']),
          row['in_stock'] == '1',
          row['release_date'],
          row['description'],
        );
        _toys.add(t);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

class ToysList extends StatefulWidget {
  const ToysList({Key? key}) : super(key: key);

  @override
  State<ToysList> createState() => _ToysListState();
}

class _ToysListState extends State<ToysList> {
  bool _load = false;

  Future<void> addToCart(int toyId) async {
    try {
      final addToCartUri = Uri.https(_baseURL, 'addToCart.php');
      final response = await http.post(
        addToCartUri,
        body: {'toy_id': toyId.toString()},
      );
      print('Response from server: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success']) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Toy Added to Cart'),
                content: Text('The toy has been added to your cart.'),
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
          print('Failed to add toy to cart: ${responseData['message']}');
        }
      } else {
        print('Failed to connect to the server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to load data')));
      }
    });
  }

  @override
  void initState() {
    updateProducts(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: !_load
                ? null
                : () {
              setState(() {
                _load = false;
                updateProducts(update);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        title: const Text('Available Toys'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _toys.length,
        itemBuilder: (context, index) => Column(
          children: [
            const SizedBox(height: 10),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _toys[index].toString(),
                            style: TextStyle(
                              fontSize: width * 0.025,
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(height: 10),
                          _toys[index].imagePath != null
                              ? Image.network(
                            _toys[index].imagePath!,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await addToCart(_toys[index].toyID);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[300],
                        onPrimary: Colors.white,
                      ),
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ToysList(),
  ));
}