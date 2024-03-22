import 'package:ShopFromUS/data/products_data.dart';
import 'package:ShopFromUS/screens/cart.dart';
import 'package:ShopFromUS/screens/product_details_screen.dart';
import 'package:ShopFromUS/widgets/products_shimmer.dart';
import 'package:flutter/material.dart';


class ProductListingPage extends StatefulWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Clothing',
    'Electronics',
    'Accessories',
    'Footwear'
  ];
  List<Product> cartItems = [];

  List<Product> getFilteredProducts(String category) {
    if (category == 'All') {
      return products;
    } else {
      return products.where((product) => product.category == category).toList();
    }
  }

  void addToCart(Product product, int quantity)async {
    if (product.availability >= quantity) {
     product.availability -= quantity; // Decrease availability
        for (int i = 0; i < quantity; i++) {
          cartItems.add(product);
         // Add to cart
        }
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

  void navigateToCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cartItems: cartItems,
          removeFromCart: (Product) {
            setState(() {
              cartItems.remove(Product);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ShopFromUs',
            style: TextStyle(
              color: Color.fromARGB(255, 16, 67, 109),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: navigateToCartScreen,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: const Color(0xFF2A45ED),
            unselectedLabelColor: const Color(0xFF061F48),
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            indicatorColor: const Color(0xFF2A45ED),
            tabs: categories.map((String category) {
              return Tab(
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        body: productBuilder(),
      ),
    );
  }

  FutureBuilder<dynamic> productBuilder() {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerEffect();
          } else {
            return TabBarView(
              children: categories.map((String category) {
                return GridView.builder(

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: getFilteredProducts(category).length,
                  itemBuilder: (BuildContext context, int index) {
                    final Product product =
                        getFilteredProducts(category)[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color:const Color(0xFFF7F8FC),
                          // border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 89, 96, 96).withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset:
                                  const Offset(1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              color: const Color(0xFFF7F8FC),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: product.image,
                                      child: Image.asset(
                                        product.image,
                                        width: double.infinity,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                     Text(
                                        product.availability==0? "Out Of Stock" :   '\$${product.cost}',
                                          style:  TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:product.availability==0?Colors.red :const Color(0xFF2A45ED),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 2,
                              child: StatefulBuilder(

                                builder: (context, setCartState) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    height: product.availability > 0 ? 50 : 0,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 300),
                                      opacity: product.availability > 0 ? 1 : 0,
                                      child: IconButton(
                                        icon: const Icon(Icons.shopping_bag_outlined, size: 30),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              int quantity = 1; // Default quantity
                                              return StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState) {
                                                  return AlertDialog(
                                                    // contentPadding: EdgeInsets.all(0),
                                                    insetPadding: const EdgeInsets.all(0),
                                                    title: const Text(
                                                      '',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          product.availability > 0
                                                              ? 'Available Stock : ${product.availability}'
                                                              : 'This product is currently out of stock.',
                                                          style: TextStyle(
                                                            color: product.availability > 0
                                                                ? Colors.black
                                                                : Colors.red,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        AnimatedContainer(
                                                          duration: const Duration(milliseconds: 300),
                                                          height: product.availability > 0 ? 50 : 0,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              IconButton(
                                                                icon: const Icon(Icons.remove),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (quantity > 1) {
                                                                      quantity--;
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                quantity.toString(),
                                                                style: const TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.bold,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: const Icon(Icons.add),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (quantity < product.availability) {
                                                                      quantity++;
                                                                    }
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                  
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                          shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                        
                                                        ),
                                                        child: const Text('Cancel',style: TextStyle(
                                                          color: Colors.white,fontWeight: FontWeight.bold
                                                        ),),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                         style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 35, 67, 93)),
                                                          shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10.0),
                                                            ),
                                                          ),
                                                        
                                                        ),
                                                        child: Text(
                                                          product.availability > 0 ? 'Add to Cart' : 'OK',style: const TextStyle(
                                                            color: Colors.white,fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (product.availability > 0) {
                                                         setCartState(() {
                                                             addToCart(product, quantity);
                                                         });
                                                            Navigator.of(context).pop();
                                                          } else {
                                                            Navigator.of(context).pop();
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
        },
      );
  }
}

