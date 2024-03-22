import 'package:ShopFromUS/screens/splash_screen.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopFromUS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const SplashScreen(), // Show splash screen initially
    );
  }
}
