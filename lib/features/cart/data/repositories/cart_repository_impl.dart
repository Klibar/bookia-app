import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:bookia/features/home/domain/entities/book_entity.dart';

/// In-memory dummy cart. TODO: swap for a real "cart"/"orders" API once
/// available — the interface (CartRepository) stays the same so CartCubit
/// and the UI won't need any changes.
class CartRepositoryImpl implements CartRepository {
  final Map<int, CartItemEntity> _items = {};

  @override
  List<CartItemEntity> getItems() => _items.values.toList();

  @override
  void add(BookEntity book) {
    if (_items.containsKey(book.id)) {
      increment(book.id);
    } else {
      _items[book.id] = CartItemEntity(book: book);
    }
  }

  @override
  void increment(int bookId) {
    final item = _items[bookId];
    if (item != null) {
      _items[bookId] = item.copyWith(quantity: item.quantity + 1);
    }
  }

  @override
  void decrement(int bookId) {
    final item = _items[bookId];
    if (item == null) return;
    if (item.quantity <= 1) {
      _items.remove(bookId);
    } else {
      _items[bookId] = item.copyWith(quantity: item.quantity - 1);
    }
  }

  @override
  void remove(int bookId) {
    _items.remove(bookId);
  }

  @override
  void clear() {
    _items.clear();
  }
}
