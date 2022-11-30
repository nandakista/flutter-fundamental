import 'package:equatable/equatable.dart';

class CustomerReview extends Equatable {
  const CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  final String? name;
  final String? review;
  final String? date;

  @override
  List<Object?> get props => [name, review, date];
}
