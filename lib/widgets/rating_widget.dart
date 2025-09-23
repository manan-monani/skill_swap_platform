import 'package:flutter/material.dart';

// A widget to display a rating using stars.
class RatingWidget extends StatelessWidget {
  // The rating value.
  final double rating;
  // The size of the stars.
  final double itemSize;

  const RatingWidget({super.key, required this.rating, this.itemSize = 20.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: itemSize,
        );
      }),
    );
  }
}
