import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bookia/features/home/domain/entities/book_entity.dart';

abstract class CartRepository {
  List<CartItemEntity> getItems();
  void add(BookEntity book);
  void increment(int bookId);
  void decrement(int bookId);
  void remove(int bookId);
  void clear();
}
