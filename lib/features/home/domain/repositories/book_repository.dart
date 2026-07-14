import 'package:bookia/features/home/domain/entities/book_entity.dart';

abstract class BookRepository {
  /// Returns the list of books shown on the Home / Best Seller screen.
  /// TODO: backed by a dummy in-memory source for now, replace with a real
  /// API call (GET /books) once the endpoint is ready.
  Future<List<BookEntity>> getBooks();

  /// Returns a single book by its [id] for the Book Details screen.
  Future<BookEntity> getBookById(int id);
}
