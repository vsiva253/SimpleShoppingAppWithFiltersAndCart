import 'package:ShopFromUS/data/products_data.dart';
import 'package:flutter/material.dart';


class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  final Function(Product) removeFromCart;

  const CartScreen({super.key, required this.cartItems, required this.removeFromCart});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int totalCost = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalCost();
  }

  void calculateTotalCost() {
    totalCost = widget.cartItems.fold(0, (previousValue, product) => previousValue + int.parse(product.cost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final Product product = widget.cartItems[index];
                      return buildCartItem(product);
                    },
                  ),
                ),
                buildTotalCostContainer(),
              ],
            ),
    );
  }

  Widget buildCartItem(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          product.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '\$${product.cost}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Image.asset(
          product.image,
          width: 100,
          height: 100,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget buildTotalCostContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A45ED),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '\$$totalCost',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
