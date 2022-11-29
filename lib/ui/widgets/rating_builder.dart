import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBuilder extends StatelessWidget {
  const RatingBuilder({Key? key, this.ratingValue}) : super(key: key);

  final double? ratingValue;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: ratingValue ?? 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 16,
      unratedColor: Colors.grey.shade300,
      ignoreGestures: true,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.orange,
      ),
      onRatingUpdate: (rating) {
        //
      },
    );
  }
}
