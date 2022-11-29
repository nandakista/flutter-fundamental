import '../../domain/entities/customer_review.dart';

class CustomerReviewModel extends CustomerReview {
  CustomerReviewModel({
    String? name,
    String? review,
    String? date,
  }) : super(name: name, date: date, review: review);

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) => CustomerReviewModel(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
