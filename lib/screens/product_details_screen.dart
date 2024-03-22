import 'package:ShopFromUS/data/products_data.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // final List<Product> cartItems;
  List<Product> cartItems = [];

  void addToCart(Product product, int quantity) {
    if (product.availability >= quantity) {
      setState(() {
        product.availability -= quantity; // Decrease availability
        for (int i = 0; i < quantity; i++) {
          cartItems.add(product); // Add to cart
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Out of Stock'),
            content: const Text('This product is currently out of stock.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: widget.product.image,
                    child: Image.asset(widget.product.image),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.product.cost}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    textAlign: TextAlign.left,
                    'Product Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product.details,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount: \$${widget.product.cost}',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 24, 49, 70),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
