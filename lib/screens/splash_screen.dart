
import 'package:ShopFromUS/screens/products_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 2 seconds and then navigate to ProductListingPage
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const ProductListingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome To \n SHOP FROM US',textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 16, 85, 141)),),
            const SizedBox(height: 20,),
            Image.asset('assets/product_images/splash.jpg',width: MediaQuery.of(context).size.width/0.40,fit: BoxFit.fitWidth,),
          ],
        ), // Show a loading indicator
      ),
    );
  }
}
