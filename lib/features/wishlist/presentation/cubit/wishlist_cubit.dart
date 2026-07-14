import 'package:bookia/features/home/domain/entities/book_entity.dart';
import 'package:bookia/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<List<BookEntity>> {
  final WishlistRepository repository;

  WishlistCubit(this.repository) : super(const []);

  Future<void> load() async {
    emit(await repository.getWishlist());
  }

  Future<void> toggle(BookEntity book) async {
    await repository.toggle(book);
    emit(await repository.getWishlist());
  }

  bool isInWishlist(int bookId) => repository.isInWishlist(bookId);
}
