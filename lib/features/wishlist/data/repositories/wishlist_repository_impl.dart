import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:bookia/features/wishlist/domain/repositories/wishlist_repository.dart';

/// In-memory dummy store. TODO: replace with SharedPreferences persistence
/// or a real "wishlist" API endpoint (mirrors AuthRepositoryImpl's token
/// storage pattern) once the backend is ready.
class WishlistRepositoryImpl implements WishlistRepository {
  final Map<int, BookEntity> _items = {};

  @override
  Future<List<BookEntity>> getWishlist() async {
    return _items.values.toList();
  }

  @override
  Future<void> toggle(BookEntity book) async {
    if (_items.containsKey(book.id)) {
      _items.remove(book.id);
    } else {
      _items[book.id] = book;
    }
  }

  @override
  bool isInWishlist(int bookId) => _items.containsKey(bookId);
}
