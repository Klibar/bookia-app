import 'package:bookia/features/home/domain/entities/book_entity.dart';

abstract class WishlistRepository {
  Future<List<BookEntity>> getWishlist();
  Future<void> toggle(BookEntity book);
  bool isInWishlist(int bookId);
}
