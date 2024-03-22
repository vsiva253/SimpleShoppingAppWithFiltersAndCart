
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.white,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            color: Colors.white,
          );
        },
      ),
    );
  }
}