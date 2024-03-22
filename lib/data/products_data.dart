
class Product {
  final String name;
  final int id;
  final String cost; // Changed type to String
   int availability;
  final String details;
  final String category;
  final String image;

  Product({
    required this.name,
    required this.id,
    required this.cost,
    required this.availability,
    required this.details,
    required this.category,
    required this.image,
  });
}

List<Product> products = [
  Product(
    name: "Adidas T-Shirt",
    id: 1,
    cost: "1000", // Changed type to String
    availability: 1,
    details: "Imported from Swiss. Made with high-quality fabric.",
    category: "Clothing",
    image: "assets/product_images/product1.jpg",
  ),
  Product(
    name: "Adidas Buds",
    id: 2,
    cost: "5000", // Changed type to String
    availability: 1,
    details: "Farmed at Selam. Provides excellent sound quality.",
    category: "Electronics",
    image: "assets/product_images/product2.jpg",
  ),
  Product(
    name: "Adidas Jacket",
    id: 3,
    cost: "2000", // Changed type to String
    availability: 10,
    details: "Stay warm and stylish with this jacket.",
    category: "Clothing",
    image: "assets/product_images/product3.jpg",
  ),
  Product(
    name: "Adidas Water Bottle",
    id: 4,
    cost: "250", // Changed type to String
    availability: 10,
    details: "Stay hydrated with this premium water bottle.",
    category: "Accessories",
    image: "assets/product_images/product4.jpg",
  ),
  Product(
    name: "Cooling Glasses",
    id: 5,
    cost: "720", // Changed type to String
    availability: 10,
    details: "Protect your eyes from harmful UV rays.",
    category: "Accessories",
    image: "assets/product_images/product5.jpg",
  ),
  Product(
    name: "Cap",
    id: 6,
    cost: "400", // Changed type to String
    availability: 10,
    details: "Complete your look with this stylish cap.",
    category: "Accessories",
    image: "assets/product_images/product6.jpg",
  ),
  Product(
    name: "Bag",
    id: 7,
    cost: "780", // Changed type to String
    availability: 10,
    details: "Carry your essentials in style with this bag.",
    category: "Accessories",
    image: "assets/product_images/product7.jpg",
  ),
  Product(
    name: "Shoes",
    id: 8,
    cost: "890", // Changed type to String
    availability: 10,
    details: "Walk comfortably with these premium shoes.",
    category: "Footwear",
    image: "assets/product_images/product8.jpg",
  ),
];
