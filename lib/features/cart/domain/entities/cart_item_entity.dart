import 'package:bookia/features/home/domain/entities/book_entity.dart';

class CartItemEntity {
  final BookEntity book;
  final int quantity;

  const CartItemEntity({required this.book, this.quantity = 1});

  double get subtotal => book.price * quantity;

  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(book: book, quantity: quantity ?? this.quantity);
  }
}
