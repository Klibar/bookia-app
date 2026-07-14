import 'package:bookia/features/cart/domain/repositories/cart_repository.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(CartState(repository.getItems()));

  void addToCart(BookEntity book) {
    repository.add(book);
    _refresh();
  }

  void increment(int bookId) {
    repository.increment(bookId);
    _refresh();
  }

  void decrement(int bookId) {
    repository.decrement(bookId);
    _refresh();
  }

  void remove(int bookId) {
    repository.remove(bookId);
    _refresh();
  }

  void clear() {
    repository.clear();
    _refresh();
  }

  void _refresh() => emit(CartState(repository.getItems()));
}
