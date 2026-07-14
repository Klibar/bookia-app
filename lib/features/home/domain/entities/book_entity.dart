class BookEntity {
  final int id;
  final String title;
  final String author;
  final double price;
  final String coverImage;
  final String description;
  final bool isBestSeller;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.coverImage,
    required this.description,
    this.isBestSeller = false,
  });
}
