import 'package:bookia/features/home/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.price,
    required super.coverImage,
    required super.description,
    super.isBestSeller,
  });

  /// Kept for when the real API is connected. Adjust the keys below to
  /// whatever codingarabic.online returns for GET /books.
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title: json['title']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0,
      coverImage: json['image']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isBestSeller: json['is_best_seller'] == true,
    );
  }
}
