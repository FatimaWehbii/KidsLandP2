    import 'package:flutter/material.dart';
    import 'toys.dart';

    class ShoppingCart {
    List<Toys> items = [];

    void addToCart(Toys toy) {
    items.add(toy);
    }

    double calculateTotal() {
    double total = 0;
    for (var item in items) {
    total += item.toyprice;
    }
    return total;
    }
    }

    final ShoppingCart shoppingCart = ShoppingCart();